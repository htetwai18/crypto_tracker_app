import '../local/drift/dao/app_dao.dart';

abstract interface class CoinLocalDataSource {
  Stream<Set<String>> watchFavoriteIds();

  Future<bool> isFavorite(String coinId);

  Future<void> setFavorite({
    required String coinId,
    required bool favorite,
  });

  Future<String?> cachedMarketsPage({
    required int page,
    required String normalizedSearchQuery,
  });

  Future<void> persistMarketsPage({
    required int page,
    required String normalizedSearchQuery,
    required String payloadJson,
  });

  Future<DateTime?> cachedMarketsPageFetchedAt({
    required int page,
    required String normalizedSearchQuery,
  });

  Future<void> clearMarketsCache();

  Future<String?> cachedTrendingJson();
  Future<DateTime?> cachedTrendingFetchedAt();

  Future<void> persistTrendingJson(String payloadJson);

  Future<String?> cachedGlobalJson();
  Future<DateTime?> cachedGlobalFetchedAt();

  Future<void> persistGlobalJson(String payloadJson);

  Future<String?> cachedCoinDetailJson(String coinId);
  Future<DateTime?> cachedCoinDetailFetchedAt(String coinId);

  Future<void> persistCoinDetailJson(String coinId, String payloadJson);
}

final class CoinLocalDataSourceImpl implements CoinLocalDataSource {
  CoinLocalDataSourceImpl(this._dao);

  final AppDao _dao;

  @override
  Stream<Set<String>> watchFavoriteIds() {
    return _dao.watchFavorites().map(
      (rows) => rows.map((row) => row.coinId).toSet(),
    );
  }

  @override
  Future<bool> isFavorite(String coinId) => _dao.isFavorite(coinId);

  @override
  Future<void> setFavorite({
    required String coinId,
    required bool favorite,
  }) async {
    if (favorite) {
      await _dao.addFavorite(coinId);
    } else {
      await _dao.removeFavorite(coinId);
    }
  }

  @override
  Future<String?> cachedMarketsPage({
    required int page,
    required String normalizedSearchQuery,
  }) async {
    final row = await _dao.getMarketsPage(page, normalizedSearchQuery);
    return row?.payloadJson;
  }

  @override
  Future<void> persistMarketsPage({
    required int page,
    required String normalizedSearchQuery,
    required String payloadJson,
  }) {
    return _dao.upsertMarketsPage(
      page: page,
      searchQuery: normalizedSearchQuery,
      payloadJson: payloadJson,
    );
  }

  @override
  Future<DateTime?> cachedMarketsPageFetchedAt({
    required int page,
    required String normalizedSearchQuery,
  }) =>
      _dao.getMarketsPageFetchedAt(page, normalizedSearchQuery);

  @override
  Future<void> clearMarketsCache() => _dao.clearMarketsCache();

  @override
  Future<String?> cachedTrendingJson() async =>
      (await _dao.getTrending())?.payloadJson;

  @override
  Future<DateTime?> cachedTrendingFetchedAt() => _dao.getTrendingFetchedAt();

  @override
  Future<void> persistTrendingJson(String payloadJson) =>
      _dao.upsertTrending(payloadJson);

  @override
  Future<String?> cachedGlobalJson() async =>
      (await _dao.getGlobal())?.payloadJson;

  @override
  Future<DateTime?> cachedGlobalFetchedAt() => _dao.getGlobalFetchedAt();

  @override
  Future<void> persistGlobalJson(String payloadJson) =>
      _dao.upsertGlobal(payloadJson);

  @override
  Future<String?> cachedCoinDetailJson(String coinId) async =>
      (await _dao.getCoinDetail(coinId))?.payloadJson;

  @override
  Future<DateTime?> cachedCoinDetailFetchedAt(String coinId) =>
      _dao.getCoinDetailFetchedAt(coinId);

  @override
  Future<void> persistCoinDetailJson(String coinId, String payloadJson) =>
      _dao.upsertCoinDetail(coinId, payloadJson);
}
