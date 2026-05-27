import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'coingecko_interceptors.dart';

/// Factory for shared [Dio] instance (timeouts, JSON, base URL).
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 25),
      receiveTimeout: const Duration(seconds: 25),
      headers: const {'Accept': 'application/json'},
      responseType: ResponseType.json,
    ),
  );
  CoinGeckoInterceptors.install(dio);
  return dio;
}
