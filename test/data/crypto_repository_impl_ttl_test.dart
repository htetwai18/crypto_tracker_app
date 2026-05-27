import 'dart:convert';

import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/data/datasources/local/coin_local_datasource.dart';
import 'package:crypto_tracker_app/data/datasources/remote/coin_remote_datasource.dart';
import 'package:crypto_tracker_app/data/repositories/crypto_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_network_info.dart';

class _FakeRemoteDataSource implements CoinRemoteDataSource {
  int fetchMarketsPageCalls = 0;
  int fetchGlobalCalls = 0;
  int fetchTrendingCalls = 0;
  int fetchCoinDetailCalls = 0;

  @override
  Future<Map<String, dynamic>> fetchCoinDetail(String coinId) async {
    fetchCoinDetailCalls++;
    return <String, dynamic>{
      'id': coinId,
      'symbol': 'btc',
      'name': 'Bitcoin',
      'image': {'small': 'img'},
      'market_data': {
        'current_price': {'usd': 100000},
      },
    };
  }

  @override
  Future<Map<String, dynamic>> fetchGlobal() async {
    fetchGlobalCalls++;
    return <String, dynamic>{
      'data': {
        'total_market_cap': {'usd': 1},
        'total_volume': {'usd': 2},
      },
    };
  }

  @override
  Future<List<dynamic>> fetchMarketsForIds(List<String> ids) async {
    return [
      {
        'id': 'bitcoin',
        'symbol': 'btc',
        'name': 'Bitcoin',
        'image': '',
        'current_price': 100000,
      },
    ];
  }

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
        'current_price': 100000,
      },
    ];
  }

  @override
  Future<Map<String, dynamic>> fetchTrending() async {
    fetchTrendingCalls++;
    return <String, dynamic>{
      'coins': [
        {
          'item': {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        },
      ],
    };
  }

  @override
  Future<List<String>> searchCoinIds(String query, {int maxResults = 200}) async {
    return const ['bitcoin'];
  }
}

class _FakeLocalDataSource implements CoinLocalDataSource {
  final Map<String, String> marketsPayloadByKey = {};
  final Map<String, DateTime> marketsFetchedAtByKey = {};

  String? trendingPayload;
  DateTime? trendingFetchedAt;

  String? globalPayload;
  DateTime? globalFetchedAt;

  final Map<String, String> coinDetailPayloadById = {};
  final Map<String, DateTime> coinDetailFetchedAtById = {};

  int persistMarketsPageCalls = 0;

  String _marketsKey(int page, String search) => '$page|$search';

  @override
  Future<String?> cachedCoinDetailJson(String coinId) async =>
      coinDetailPayloadById[coinId];

  @override
  Future<DateTime?> cachedCoinDetailFetchedAt(String coinId) async =>
      coinDetailFetchedAtById[coinId];

  @override
  Future<String?> cachedGlobalJson() async => globalPayload;

  @override
  Future<DateTime?> cachedGlobalFetchedAt() async => globalFetchedAt;

  @override
  Future<String?> cachedMarketsPage({
    required int page,
    required String normalizedSearchQuery,
  }) async => marketsPayloadByKey[_marketsKey(page, normalizedSearchQuery)];

  @override
  Future<DateTime?> cachedMarketsPageFetchedAt({
    required int page,
    required String normalizedSearchQuery,
  }) async => marketsFetchedAtByKey[_marketsKey(page, normalizedSearchQuery)];

  @override
  Future<String?> cachedTrendingJson() async => trendingPayload;

  @override
  Future<DateTime?> cachedTrendingFetchedAt() async => trendingFetchedAt;

  @override
  Future<void> clearMarketsCache() async {
    marketsPayloadByKey.clear();
    marketsFetchedAtByKey.clear();
  }

  @override
  Future<bool> isFavorite(String coinId) async => false;

  @override
  Future<void> persistCoinDetailJson(String coinId, String payloadJson) async {
    coinDetailPayloadById[coinId] = payloadJson;
    coinDetailFetchedAtById[coinId] = DateTime.now();
  }

  @override
  Future<void> persistGlobalJson(String payloadJson) async {
    globalPayload = payloadJson;
    globalFetchedAt = DateTime.now();
  }

  @override
  Future<void> persistMarketsPage({
    required int page,
    required String normalizedSearchQuery,
    required String payloadJson,
  }) async {
    persistMarketsPageCalls++;
    marketsPayloadByKey[_marketsKey(page, normalizedSearchQuery)] = payloadJson;
    marketsFetchedAtByKey[_marketsKey(page, normalizedSearchQuery)] =
        DateTime.now();
  }

  @override
  Future<void> persistTrendingJson(String payloadJson) async {
    trendingPayload = payloadJson;
    trendingFetchedAt = DateTime.now();
  }

  @override
  Future<void> setFavorite({
    required String coinId,
    required bool favorite,
  }) async {}

  @override
  Stream<Set<String>> watchFavoriteIds() => Stream.value(const <String>{});
}

void main() {
  test('uses fresh markets cache and skips remote call', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: true);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.marketsPayloadByKey['1|'] = jsonEncode([
      {
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
        'image': '',
        'current_price': 3000,
      },
    ]);
    local.marketsFetchedAtByKey['1|'] = DateTime.now().subtract(
      const Duration(minutes: 1),
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 0);
  });

  test('fetches remote markets when cache is stale', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: true);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.marketsPayloadByKey['1|'] = jsonEncode([
      {
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
        'image': '',
        'current_price': 3000,
      },
    ]);
    local.marketsFetchedAtByKey['1|'] = DateTime.now().subtract(
      const Duration(minutes: 5),
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 1);
    expect(local.persistMarketsPageCalls, 1);
  });

  test('uses fresh trending/global cache and skips remote calls', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: true);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.globalPayload = jsonEncode({
      'data': {
        'total_market_cap': {'usd': 1},
        'total_volume': {'usd': 2},
      },
    });
    local.trendingPayload = jsonEncode({
      'coins': [
        {
          'item': {'id': 'bitcoin', 'symbol': 'btc', 'name': 'Bitcoin'},
        },
      ],
    });
    final fresh = DateTime.now().subtract(const Duration(minutes: 2));
    local.globalFetchedAt = fresh;
    local.trendingFetchedAt = fresh;

    final result = await repo.getTrendingAndGlobal();
    expect(result.isOk, isTrue);
    expect(remote.fetchGlobalCalls, 0);
    expect(remote.fetchTrendingCalls, 0);
  });

  test('uses fresh detail cache and skips remote detail call', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: true);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.coinDetailPayloadById['bitcoin'] = jsonEncode({
      'id': 'bitcoin',
      'symbol': 'btc',
      'name': 'Bitcoin',
      'image': {'small': ''},
      'market_data': {
        'current_price': {'usd': 100000},
      },
    });
    local.coinDetailFetchedAtById['bitcoin'] = DateTime.now().subtract(
      const Duration(minutes: 3),
    );

    final result = await repo.getCoinDetail('bitcoin');
    expect(result, isA<Ok>());
    expect(remote.fetchCoinDetailCalls, 0);
  });

  test('forces remote markets when forceRemote=true even if cache is fresh', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: true);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.marketsPayloadByKey['1|'] = jsonEncode([
      {
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
        'image': '',
        'current_price': 3000,
      },
    ]);
    local.marketsFetchedAtByKey['1|'] = DateTime.now().subtract(
      const Duration(seconds: 30),
    );

    final result = await repo.getMarketsPage(page: 1, forceRemote: true);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 1);
  });

  test('returns cached markets while offline even when cache is stale', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: false);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    local.marketsPayloadByKey['1|'] = jsonEncode([
      {
        'id': 'ethereum',
        'symbol': 'eth',
        'name': 'Ethereum',
        'image': '',
        'current_price': 3000,
      },
    ]);
    local.marketsFetchedAtByKey['1|'] = DateTime.now().subtract(
      const Duration(days: 7),
    );

    final result = await repo.getMarketsPage(page: 1);
    expect(result, isA<Ok<List>>());
    expect(remote.fetchMarketsPageCalls, 0);
  });

  test('returns NetworkUnavailableFailure when offline and no markets cache', () async {
    final local = _FakeLocalDataSource();
    final remote = _FakeRemoteDataSource();
    final network = StubNetworkInfo(online: false);
    final repo = CryptoRepositoryImpl(networkInfo: network, remote: remote, local: local);

    final result = await repo.getMarketsPage(page: 1);
    expect(result.isErr, isTrue);
    expect(result.err?.failure.message, contains('No network connection'));
    expect(remote.fetchMarketsPageCalls, 0);
  });
}
