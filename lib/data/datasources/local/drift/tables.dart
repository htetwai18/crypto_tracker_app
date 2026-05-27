import 'package:drift/drift.dart';

/// Local favorite coin ids (CoinGecko id).
class Favorites extends Table {
  TextColumn get coinId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {coinId};
}

/// Paginated markets API response cache (JSON body per page + optional search key).
class CacheMarketsPages extends Table {
  IntColumn get page => integer()();
  TextColumn get searchQuery => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {page, searchQuery};
}

/// Single-row cache for `/search/trending` (use `id` = 1).
class CacheTrending extends Table {
  IntColumn get id => integer()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Single-row cache for `/global` (use `id` = 1).
class CacheGlobal extends Table {
  IntColumn get id => integer()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Per-coin detail JSON cache.
class CacheCoinDetail extends Table {
  TextColumn get coinId => text()();
  TextColumn get payloadJson => text()();
  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {coinId};
}
