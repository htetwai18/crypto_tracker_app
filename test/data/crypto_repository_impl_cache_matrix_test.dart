import 'dart:convert';

import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/data/datasources/local/coin_local_datasource.dart';
import 'package:crypto_tracker_app/data/datasources/remote/coin_remote_datasource.dart';
import 'package:crypto_tracker_app/data/repositories/crypto_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_network_info.dart';

class _MatrixRemoteDataSource implements CoinRemoteDataSource {
  int fetchMarketsPageCalls = 0;
  int fetchCoinDetailCalls = 0;
  int fetchGlobalCalls = 0;
  int fetchTrendingCalls = 0;

  @override
  Future<List<dynamic>> fetchMarketsPage({
    required int page,
    required int perPage,
  }) async {
    fetchMarketsPageCalls++;
    return [
      {
        'id': 'bitcoin',
        'symbol': 'btc',
        'name': 'Bitcoin',
        'image': '',
        'current_price': 123.0,
      },
    ];
  }

  @override
  Future<Map<String, dynamic>> fetchCoinDetail(String coinId) async {
    fetchCoinDetailCalls++;
    return {
      'id': coinId,
      'symbol': 'btc',
      'name': 'Bitcoin',
      'image': {'small': ''},
      'market_data': {
        'current_price': {'usd': 100.0},
      },
    };
  }

  @override
  Future<Map<String, dynamic>> fetchGlobal() async {
    fetchGlobalCalls++;
    return {
      'data': {
        'total_market_cap': {'usd': 1.0},
        'total_volume': {'usd': 2.0},
      },
    };
  }

  @override
  Future<Map<String, dynamic>> fetchTrending() async {
    fetchTrendingCalls++;
    return {
      'coins': [
        {
          'item': {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        },
      ],
    };
  }

  @override
  Future<List<dynamic>> fetchMarketsForIds(List<String> ids) =>
      fetchMarketsPage(page: 1, perPage: 1);

  @override
  Future<List<String>> searchCoinIds(String query, {int maxResults = 200}) async =>
      const ['bitcoin'];
}

class _MatrixLocalDataSource implements CoinLocalDataSource {
  String? marketsPayload;
  DateTime? marketsFetchedAt;
  String? trendingPayload;
  DateTime? trendingFetchedAt;
  String? globalPayload;
  DateTime? globalFetchedAt;

  @override
  Future<String?> cachedMarketsPage({
    required int page,
    required String normalizedSearchQuery,
  }) async => marketsPayload;

  @override
  Future<DateTime?> cachedMarketsPageFetchedAt({
    required int page,
    required String normalizedSearchQuery,
  }) async => marketsFetchedAt;

  @override
  Future<String?> cachedGlobalJson() async => globalPayload;

  @override
  Future<DateTime?> cachedGlobalFetchedAt() async => globalFetchedAt;

  @override
  Future<String?> cachedTrendingJson() async => trendingPayload;

  @override
  Future<DateTime?> cachedTrendingFetchedAt() async => trendingFetchedAt;

  @override
  Future<String?> cachedCoinDetailJson(String coinId) async => null;

  @override
  Future<DateTime?> cachedCoinDetailFetchedAt(String coinId) async => null;

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
  Future<void> setFavorite({required String coinId, required bool favorite}) async {}

  @override
  Stream<Set<String>> watchFavoriteIds() => Stream.value(const <String>{});
}

void main() {
  test('fresh markets cache + online + forceRemote=false returns cache', () async {
    final local = _MatrixLocalDataSource();
    local.marketsPayload = jsonEncode([
      {
        'id': 'cached',
        'symbol': 'ch',
        'name': 'Cached',
        'image': '',
        'current_price': 1,
      },
    ]);
    local.marketsFetchedAt = DateTime.now().subtract(const Duration(minutes: 1));
    final remote = _MatrixRemoteDataSource();
    final repo = CryptoRepositoryImpl(
      networkInfo: StubNetworkInfo(online: true),
      remote: remote,
      local: local,
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 0);
  });

  test('offline + cache exists returns cache', () async {
    final local = _MatrixLocalDataSource();
    local.marketsPayload = jsonEncode([
      {
        'id': 'cached',
        'symbol': 'ch',
        'name': 'Cached',
        'image': '',
        'current_price': 1,
      },
    ]);
    local.marketsFetchedAt = DateTime.now().subtract(const Duration(days: 1));
    final remote = _MatrixRemoteDataSource();
    final repo = CryptoRepositoryImpl(
      networkInfo: StubNetworkInfo(online: false),
      remote: remote,
      local: local,
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 0);
  });

  test('offline + cache missing returns NetworkUnavailableFailure', () async {
    final local = _MatrixLocalDataSource();
    final remote = _MatrixRemoteDataSource();
    final repo = CryptoRepositoryImpl(
      networkInfo: StubNetworkInfo(online: false),
      remote: remote,
      local: local,
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result.isErr, isTrue);
    expect(result.err?.failure, isA<NetworkUnavailableFailure>());
  });
}
