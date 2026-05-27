import 'package:drift/drift.dart';

import '../database.dart';
import '../tables.dart';

part 'app_dao.g.dart';

const int _singletonCacheId = 1;

@DriftAccessor(
  tables: [
    Favorites,
    CacheMarketsPages,
    CacheTrending,
    CacheGlobal,
    CacheCoinDetail,
  ],
)
class AppDao extends DatabaseAccessor<AppDatabase> with _$AppDaoMixin {
  AppDao(super.db);

  // --- Favorites ---

  Future<List<Favorite>> get allFavorites => (select(
    favorites,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  Stream<List<Favorite>> watchFavorites() => (select(
    favorites,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();

  Future<bool> isFavorite(String coinId) async {
    final row = await (select(
      favorites,
    )..where((t) => t.coinId.equals(coinId))).getSingleOrNull();
    return row != null;
  }

  Future<void> addFavorite(String coinId) async {
    await into(
      favorites,
    ).insertOnConflictUpdate(FavoritesCompanion.insert(coinId: coinId));
  }

  Future<void> removeFavorite(String coinId) async {
    await (delete(favorites)..where((t) => t.coinId.equals(coinId))).go();
  }

  // --- Markets pages ---

  Future<CacheMarketsPage?> getMarketsPage(int page, String searchQuery) {
    return (select(cacheMarketsPages)..where(
          (t) => t.page.equals(page) & t.searchQuery.equals(searchQuery),
        ))
        .getSingleOrNull();
  }

  Future<DateTime?> getMarketsPageFetchedAt(
    int page,
    String searchQuery,
  ) async {
    final row = await getMarketsPage(page, searchQuery);
    return row?.fetchedAt;
  }

  Future<void> upsertMarketsPage({
    required int page,
    required String searchQuery,
    required String payloadJson,
  }) {
    return into(cacheMarketsPages).insertOnConflictUpdate(
      CacheMarketsPagesCompanion.insert(
        page: page,
        searchQuery: searchQuery,
        payloadJson: payloadJson,
        fetchedAt: DateTime.now(),
      ),
    );
  }

  Future<void> clearMarketsCache() => delete(cacheMarketsPages).go();

  // --- Trending ---

  Future<CacheTrendingData?> getTrending() {
    return (select(
      cacheTrending,
    )..where((t) => t.id.equals(_singletonCacheId))).getSingleOrNull();
  }

  Future<DateTime?> getTrendingFetchedAt() async {
    final row = await getTrending();
    return row?.fetchedAt;
  }

  Future<void> upsertTrending(String payloadJson) {
    return into(cacheTrending).insertOnConflictUpdate(
      CacheTrendingCompanion.insert(
        id: Value(_singletonCacheId),
        payloadJson: payloadJson,
        fetchedAt: DateTime.now(),
      ),
    );
  }

  // --- Global ---

  Future<CacheGlobalData?> getGlobal() {
    return (select(
      cacheGlobal,
    )..where((t) => t.id.equals(_singletonCacheId))).getSingleOrNull();
  }

  Future<DateTime?> getGlobalFetchedAt() async {
    final row = await getGlobal();
    return row?.fetchedAt;
  }

  Future<void> upsertGlobal(String payloadJson) {
    return into(cacheGlobal).insertOnConflictUpdate(
      CacheGlobalCompanion.insert(
        id: Value(_singletonCacheId),
        payloadJson: payloadJson,
        fetchedAt: DateTime.now(),
      ),
    );
  }

  // --- Coin detail ---

  Future<CacheCoinDetailData?> getCoinDetail(String coinId) {
    return (select(
      cacheCoinDetail,
    )..where((t) => t.coinId.equals(coinId))).getSingleOrNull();
  }

  Future<DateTime?> getCoinDetailFetchedAt(String coinId) async {
    final row = await getCoinDetail(coinId);
    return row?.fetchedAt;
  }

  Future<void> upsertCoinDetail(String coinId, String payloadJson) {
    return into(cacheCoinDetail).insertOnConflictUpdate(
      CacheCoinDetailCompanion.insert(
        coinId: coinId,
        payloadJson: payloadJson,
        fetchedAt: DateTime.now(),
      ),
    );
  }
}
