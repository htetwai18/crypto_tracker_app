import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'dao/app_dao.dart';
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Favorites,
    CacheMarketsPages,
    CacheTrending,
    CacheGlobal,
    CacheCoinDetail,
  ],
  daos: [AppDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  factory AppDatabase.inMemoryForTests(QueryExecutor executor) {
    return AppDatabase(executor);
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'crypto_tracker_db.sqlite');
  }
}
