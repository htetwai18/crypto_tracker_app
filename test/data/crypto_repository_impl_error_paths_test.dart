import 'dart:convert';

import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/data/datasources/local/coin_local_datasource.dart';
import 'package:crypto_tracker_app/data/datasources/remote/coin_remote_datasource.dart';
import 'package:crypto_tracker_app/data/repositories/crypto_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_network_info.dart';

class _ErrorRemoteDataSource implements CoinRemoteDataSource {
  _ErrorRemoteDataSource({required this.throwOn});

  final String throwOn;

  DioException _dioEx() => DioException(
    requestOptions: RequestOptions(path: '/'),
    type: DioExceptionType.badResponse,
    response: Response(
      requestOptions: RequestOptions(path: '/'),
      statusCode: 503,
    ),
  );

  @override
  Future<Map<String, dynamic>> fetchCoinDetail(String coinId) async {
    if (throwOn == 'detail') throw _dioEx();
    return {
      'id': coinId,
      'symbol': 'btc',
      'name': 'Bitcoin',
      'image': {'small': ''},
      'market_data': {
        'current_price': {'usd': 99.0},
      },
    };
  }

  @override
  Future<Map<String, dynamic>> fetchGlobal() async {
    if (throwOn == 'global') throw _dioEx();
    return {
      'data': {
        'total_market_cap': {'usd': 1.0},
        'total_volume': {'usd': 2.0},
      },
    };
  }

  @override
  Future<List<dynamic>> fetchMarketsForIds(List<String> ids) =>
      fetchMarketsPage(page: 1, perPage: 20);

  @override
  Future<List<dynamic>> fetchMarketsPage({
    required int page,
    required int perPage,
  }) async {
    if (throwOn == 'markets') throw _dioEx();
    return [
      {
        'id': 'bitcoin',
        'symbol': 'btc',
        'name': 'Bitcoin',
        'image': '',
        'current_price': 100.0,
      },
    ];
  }

  @override
  Future<Map<String, dynamic>> fetchTrending() async {
    if (throwOn == 'trending') throw _dioEx();
    return {
      'coins': [
        {
          'item': {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        },
      ],
    };
  }

  @override
  Future<List<String>> searchCoinIds(
    String query, {
    int maxResults = 200,
  }) async => const ['bitcoin'];
}

class _ErrorLocalDataSource implements CoinLocalDataSource {
  String? marketsPayload;
  String? globalPayload;
  String? trendingPayload;
  String? coinDetailPayload;

  @override
  Future<String?> cachedMarketsPage({
    required int page,
    required String normalizedSearchQuery,
  }) async => marketsPayload;

  @override
  Future<DateTime?> cachedMarketsPageFetchedAt({
    required int page,
    required String normalizedSearchQuery,
  }) async => DateTime.now().subtract(const Duration(days: 7));

  @override
  Future<String?> cachedGlobalJson() async => globalPayload;

  @override
  Future<DateTime?> cachedGlobalFetchedAt() async =>
      DateTime.now().subtract(const Duration(days: 7));

  @override
  Future<String?> cachedTrendingJson() async => trendingPayload;

  @override
  Future<DateTime?> cachedTrendingFetchedAt() async =>
      DateTime.now().subtract(const Duration(days: 7));

  @override
  Future<String?> cachedCoinDetailJson(String coinId) async =>
      coinDetailPayload;

  @override
  Future<DateTime?> cachedCoinDetailFetchedAt(String coinId) async =>
      DateTime.now().subtract(const Duration(days: 7));

  @override
  Future<void> clearMarketsCache() async {}
  @override
  Future<bool> isFavorite(String coinId) async => false;
  @override
  Future<void> persistCoinDetailJson(String coinId, String payloadJson) async {}
  @override
  Future<void> persistGlobalJson(String payloadJson) async {}
  @override
  Future<void> persistMarketsPage({
    required int page,
    required String normalizedSearchQuery,
    required String payloadJson,
  }) async {}
  @override
  Future<void> persistTrendingJson(String payloadJson) async {}
  @override
  Future<void> setFavorite({
    required String coinId,
    required bool favorite,
  }) async {}
  @override
  Stream<Set<String>> watchFavoriteIds() => Stream.value(const <String>{});
}

void main() {
  test('markets Dio error falls back to disk cache when available', () async {
    final local = _ErrorLocalDataSource()
      ..marketsPayload = jsonEncode([
        {
          'id': 'cached',
          'symbol': 'cc',
          'name': 'Cached',
          'image': '',
          'current_price': 1,
        },
      ]);
    final repo = CryptoRepositoryImpl(
      networkInfo: StubNetworkInfo(online: true),
      remote: _ErrorRemoteDataSource(throwOn: 'markets'),
      local: local,
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result.isOk, isTrue);
  });

  test('header Dio error falls back to disk cache when available', () async {
    final local = _ErrorLocalDataSource()
      ..globalPayload = jsonEncode({
        'data': {
          'total_market_cap': {'usd': 1},
          'total_volume': {'usd': 2},
        },
      })
      ..trendingPayload = jsonEncode({
        'coins': [
          {
            'item': {'id': 'cached', 'symbol': 'cc', 'name': 'Cached'},
          },
        ],
      });
    final repo = CryptoRepositoryImpl(
      networkInfo: StubNetworkInfo(online: true),
      remote: _ErrorRemoteDataSource(throwOn: 'global'),
      local: local,
    );

    final result = await repo.getTrendingAndGlobal(forceRemote: true);
    expect(result.isOk, isTrue);
  });

  test(
    'detail Dio error returns mapped server failure when no cache',
    () async {
      final local = _ErrorLocalDataSource();
      final repo = CryptoRepositoryImpl(
        networkInfo: StubNetworkInfo(online: true),
        remote: _ErrorRemoteDataSource(throwOn: 'detail'),
        local: local,
      );

      final result = await repo.getCoinDetail('bitcoin', forceRemote: true);
      expect(result.isErr, isTrue);
      expect(result.err?.failure, isA<ServerFailure>());
    },
  );
}
