import 'package:dio/dio.dart';

/// Serializes CoinGecko calls and retries HTTP 429 with backoff.
final class CoinGeckoInterceptors extends QueuedInterceptor {
  CoinGeckoInterceptors(Dio dio)
    : _retryDio = Dio(
        BaseOptions(
          baseUrl: dio.options.baseUrl,
          connectTimeout: dio.options.connectTimeout,
          receiveTimeout: dio.options.receiveTimeout,
          headers: dio.options.headers,
          responseType: dio.options.responseType,
        ),
      );

  /// Retries must not reuse the queued [Dio] client or requests can deadlock.
  final Dio _retryDio;

  static const _minGap = Duration(milliseconds: 700);
  static const _maxRetries = 2;

  DateTime _lastRequestAt = DateTime.fromMillisecondsSinceEpoch(0);

  static void install(Dio dio) {
    dio.interceptors.add(CoinGeckoInterceptors(dio));
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final wait = _lastRequestAt.add(_minGap).difference(DateTime.now());
    if (wait > Duration.zero) {
      await Future<void>.delayed(wait);
    }
    _lastRequestAt = DateTime.now();
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 429) {
      handler.next(err);
      return;
    }

    final retryCount = (err.requestOptions.extra['retryCount'] as int?) ?? 0;
    if (retryCount >= _maxRetries) {
      handler.next(err);
      return;
    }

    final retryAfterHeader = err.response?.headers.value('retry-after');
    final retryAfterSecs = int.tryParse(retryAfterHeader ?? '');
    final delay = retryAfterSecs != null && retryAfterSecs > 0
        ? Duration(seconds: retryAfterSecs.clamp(1, 60))
        : Duration(seconds: 2 * (retryCount + 1));

    await Future<void>.delayed(delay);

    final options = err.requestOptions;
    options.extra['retryCount'] = retryCount + 1;

    try {
      final response = await _retryDio.fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
