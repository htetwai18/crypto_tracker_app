// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_dao.dart';

// ignore_for_file: type=lint
mixin _$AppDaoMixin on DatabaseAccessor<AppDatabase> {
  $FavoritesTable get favorites => attachedDatabase.favorites;
  $CacheMarketsPagesTable get cacheMarketsPages =>
      attachedDatabase.cacheMarketsPages;
  $CacheTrendingTable get cacheTrending => attachedDatabase.cacheTrending;
  $CacheGlobalTable get cacheGlobal => attachedDatabase.cacheGlobal;
  $CacheCoinDetailTable get cacheCoinDetail => attachedDatabase.cacheCoinDetail;
  AppDaoManager get managers => AppDaoManager(this);
}

class AppDaoManager {
  final _$AppDaoMixin _db;
  AppDaoManager(this._db);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db.attachedDatabase, _db.favorites);
  $$CacheMarketsPagesTableTableManager get cacheMarketsPages =>
      $$CacheMarketsPagesTableTableManager(
        _db.attachedDatabase,
        _db.cacheMarketsPages,
      );
  $$CacheTrendingTableTableManager get cacheTrending =>
      $$CacheTrendingTableTableManager(_db.attachedDatabase, _db.cacheTrending);
  $$CacheGlobalTableTableManager get cacheGlobal =>
      $$CacheGlobalTableTableManager(_db.attachedDatabase, _db.cacheGlobal);
  $$CacheCoinDetailTableTableManager get cacheCoinDetail =>
      $$CacheCoinDetailTableTableManager(
        _db.attachedDatabase,
        _db.cacheCoinDetail,
      );
}
