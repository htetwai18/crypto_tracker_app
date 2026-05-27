// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coinIdMeta = const VerificationMeta('coinId');
  @override
  late final GeneratedColumn<String> coinId = GeneratedColumn<String>(
    'coin_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [coinId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coin_id')) {
      context.handle(
        _coinIdMeta,
        coinId.isAcceptableOrUnknown(data['coin_id']!, _coinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coinIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {coinId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      coinId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coin_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final String coinId;
  final DateTime createdAt;
  const Favorite({required this.coinId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coin_id'] = Variable<String>(coinId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      coinId: Value(coinId),
      createdAt: Value(createdAt),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      coinId: serializer.fromJson<String>(json['coinId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coinId': serializer.toJson<String>(coinId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Favorite copyWith({String? coinId, DateTime? createdAt}) => Favorite(
    coinId: coinId ?? this.coinId,
    createdAt: createdAt ?? this.createdAt,
  );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      coinId: data.coinId.present ? data.coinId.value : this.coinId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('coinId: $coinId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(coinId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.coinId == this.coinId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<String> coinId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.coinId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String coinId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : coinId = Value(coinId);
  static Insertable<Favorite> custom({
    Expression<String>? coinId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coinId != null) 'coin_id': coinId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith({
    Value<String>? coinId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FavoritesCompanion(
      coinId: coinId ?? this.coinId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coinId.present) {
      map['coin_id'] = Variable<String>(coinId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('coinId: $coinId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CacheMarketsPagesTable extends CacheMarketsPages
    with TableInfo<$CacheMarketsPagesTable, CacheMarketsPage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheMarketsPagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pageMeta = const VerificationMeta('page');
  @override
  late final GeneratedColumn<int> page = GeneratedColumn<int>(
    'page',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchQueryMeta = const VerificationMeta(
    'searchQuery',
  );
  @override
  late final GeneratedColumn<String> searchQuery = GeneratedColumn<String>(
    'search_query',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    page,
    searchQuery,
    payloadJson,
    fetchedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_markets_pages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheMarketsPage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('page')) {
      context.handle(
        _pageMeta,
        page.isAcceptableOrUnknown(data['page']!, _pageMeta),
      );
    } else if (isInserting) {
      context.missing(_pageMeta);
    }
    if (data.containsKey('search_query')) {
      context.handle(
        _searchQueryMeta,
        searchQuery.isAcceptableOrUnknown(
          data['search_query']!,
          _searchQueryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_searchQueryMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {page, searchQuery};
  @override
  CacheMarketsPage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheMarketsPage(
      page: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}page'],
      )!,
      searchQuery: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_query'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CacheMarketsPagesTable createAlias(String alias) {
    return $CacheMarketsPagesTable(attachedDatabase, alias);
  }
}

class CacheMarketsPage extends DataClass
    implements Insertable<CacheMarketsPage> {
  final int page;
  final String searchQuery;
  final String payloadJson;
  final DateTime fetchedAt;
  const CacheMarketsPage({
    required this.page,
    required this.searchQuery,
    required this.payloadJson,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['page'] = Variable<int>(page);
    map['search_query'] = Variable<String>(searchQuery);
    map['payload_json'] = Variable<String>(payloadJson);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CacheMarketsPagesCompanion toCompanion(bool nullToAbsent) {
    return CacheMarketsPagesCompanion(
      page: Value(page),
      searchQuery: Value(searchQuery),
      payloadJson: Value(payloadJson),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CacheMarketsPage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheMarketsPage(
      page: serializer.fromJson<int>(json['page']),
      searchQuery: serializer.fromJson<String>(json['searchQuery']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'page': serializer.toJson<int>(page),
      'searchQuery': serializer.toJson<String>(searchQuery),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CacheMarketsPage copyWith({
    int? page,
    String? searchQuery,
    String? payloadJson,
    DateTime? fetchedAt,
  }) => CacheMarketsPage(
    page: page ?? this.page,
    searchQuery: searchQuery ?? this.searchQuery,
    payloadJson: payloadJson ?? this.payloadJson,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CacheMarketsPage copyWithCompanion(CacheMarketsPagesCompanion data) {
    return CacheMarketsPage(
      page: data.page.present ? data.page.value : this.page,
      searchQuery: data.searchQuery.present
          ? data.searchQuery.value
          : this.searchQuery,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheMarketsPage(')
          ..write('page: $page, ')
          ..write('searchQuery: $searchQuery, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(page, searchQuery, payloadJson, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheMarketsPage &&
          other.page == this.page &&
          other.searchQuery == this.searchQuery &&
          other.payloadJson == this.payloadJson &&
          other.fetchedAt == this.fetchedAt);
}

class CacheMarketsPagesCompanion extends UpdateCompanion<CacheMarketsPage> {
  final Value<int> page;
  final Value<String> searchQuery;
  final Value<String> payloadJson;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const CacheMarketsPagesCompanion({
    this.page = const Value.absent(),
    this.searchQuery = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheMarketsPagesCompanion.insert({
    required int page,
    required String searchQuery,
    required String payloadJson,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : page = Value(page),
       searchQuery = Value(searchQuery),
       payloadJson = Value(payloadJson),
       fetchedAt = Value(fetchedAt);
  static Insertable<CacheMarketsPage> custom({
    Expression<int>? page,
    Expression<String>? searchQuery,
    Expression<String>? payloadJson,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (page != null) 'page': page,
      if (searchQuery != null) 'search_query': searchQuery,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheMarketsPagesCompanion copyWith({
    Value<int>? page,
    Value<String>? searchQuery,
    Value<String>? payloadJson,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return CacheMarketsPagesCompanion(
      page: page ?? this.page,
      searchQuery: searchQuery ?? this.searchQuery,
      payloadJson: payloadJson ?? this.payloadJson,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (page.present) {
      map['page'] = Variable<int>(page.value);
    }
    if (searchQuery.present) {
      map['search_query'] = Variable<String>(searchQuery.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheMarketsPagesCompanion(')
          ..write('page: $page, ')
          ..write('searchQuery: $searchQuery, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CacheTrendingTable extends CacheTrending
    with TableInfo<$CacheTrendingTable, CacheTrendingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheTrendingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payloadJson, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_trending';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheTrendingData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheTrendingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheTrendingData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CacheTrendingTable createAlias(String alias) {
    return $CacheTrendingTable(attachedDatabase, alias);
  }
}

class CacheTrendingData extends DataClass
    implements Insertable<CacheTrendingData> {
  final int id;
  final String payloadJson;
  final DateTime fetchedAt;
  const CacheTrendingData({
    required this.id,
    required this.payloadJson,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payload_json'] = Variable<String>(payloadJson);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CacheTrendingCompanion toCompanion(bool nullToAbsent) {
    return CacheTrendingCompanion(
      id: Value(id),
      payloadJson: Value(payloadJson),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CacheTrendingData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheTrendingData(
      id: serializer.fromJson<int>(json['id']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CacheTrendingData copyWith({
    int? id,
    String? payloadJson,
    DateTime? fetchedAt,
  }) => CacheTrendingData(
    id: id ?? this.id,
    payloadJson: payloadJson ?? this.payloadJson,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CacheTrendingData copyWithCompanion(CacheTrendingCompanion data) {
    return CacheTrendingData(
      id: data.id.present ? data.id.value : this.id,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheTrendingData(')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payloadJson, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheTrendingData &&
          other.id == this.id &&
          other.payloadJson == this.payloadJson &&
          other.fetchedAt == this.fetchedAt);
}

class CacheTrendingCompanion extends UpdateCompanion<CacheTrendingData> {
  final Value<int> id;
  final Value<String> payloadJson;
  final Value<DateTime> fetchedAt;
  const CacheTrendingCompanion({
    this.id = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  CacheTrendingCompanion.insert({
    this.id = const Value.absent(),
    required String payloadJson,
    required DateTime fetchedAt,
  }) : payloadJson = Value(payloadJson),
       fetchedAt = Value(fetchedAt);
  static Insertable<CacheTrendingData> custom({
    Expression<int>? id,
    Expression<String>? payloadJson,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  CacheTrendingCompanion copyWith({
    Value<int>? id,
    Value<String>? payloadJson,
    Value<DateTime>? fetchedAt,
  }) {
    return CacheTrendingCompanion(
      id: id ?? this.id,
      payloadJson: payloadJson ?? this.payloadJson,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheTrendingCompanion(')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $CacheGlobalTable extends CacheGlobal
    with TableInfo<$CacheGlobalTable, CacheGlobalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheGlobalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payloadJson, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_global';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheGlobalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CacheGlobalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheGlobalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CacheGlobalTable createAlias(String alias) {
    return $CacheGlobalTable(attachedDatabase, alias);
  }
}

class CacheGlobalData extends DataClass implements Insertable<CacheGlobalData> {
  final int id;
  final String payloadJson;
  final DateTime fetchedAt;
  const CacheGlobalData({
    required this.id,
    required this.payloadJson,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['payload_json'] = Variable<String>(payloadJson);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CacheGlobalCompanion toCompanion(bool nullToAbsent) {
    return CacheGlobalCompanion(
      id: Value(id),
      payloadJson: Value(payloadJson),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CacheGlobalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheGlobalData(
      id: serializer.fromJson<int>(json['id']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CacheGlobalData copyWith({
    int? id,
    String? payloadJson,
    DateTime? fetchedAt,
  }) => CacheGlobalData(
    id: id ?? this.id,
    payloadJson: payloadJson ?? this.payloadJson,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CacheGlobalData copyWithCompanion(CacheGlobalCompanion data) {
    return CacheGlobalData(
      id: data.id.present ? data.id.value : this.id,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheGlobalData(')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payloadJson, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheGlobalData &&
          other.id == this.id &&
          other.payloadJson == this.payloadJson &&
          other.fetchedAt == this.fetchedAt);
}

class CacheGlobalCompanion extends UpdateCompanion<CacheGlobalData> {
  final Value<int> id;
  final Value<String> payloadJson;
  final Value<DateTime> fetchedAt;
  const CacheGlobalCompanion({
    this.id = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.fetchedAt = const Value.absent(),
  });
  CacheGlobalCompanion.insert({
    this.id = const Value.absent(),
    required String payloadJson,
    required DateTime fetchedAt,
  }) : payloadJson = Value(payloadJson),
       fetchedAt = Value(fetchedAt);
  static Insertable<CacheGlobalData> custom({
    Expression<int>? id,
    Expression<String>? payloadJson,
    Expression<DateTime>? fetchedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
    });
  }

  CacheGlobalCompanion copyWith({
    Value<int>? id,
    Value<String>? payloadJson,
    Value<DateTime>? fetchedAt,
  }) {
    return CacheGlobalCompanion(
      id: id ?? this.id,
      payloadJson: payloadJson ?? this.payloadJson,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheGlobalCompanion(')
          ..write('id: $id, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }
}

class $CacheCoinDetailTable extends CacheCoinDetail
    with TableInfo<$CacheCoinDetailTable, CacheCoinDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheCoinDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coinIdMeta = const VerificationMeta('coinId');
  @override
  late final GeneratedColumn<String> coinId = GeneratedColumn<String>(
    'coin_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [coinId, payloadJson, fetchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_coin_detail';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheCoinDetailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coin_id')) {
      context.handle(
        _coinIdMeta,
        coinId.isAcceptableOrUnknown(data['coin_id']!, _coinIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coinIdMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {coinId};
  @override
  CacheCoinDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheCoinDetailData(
      coinId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coin_id'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
    );
  }

  @override
  $CacheCoinDetailTable createAlias(String alias) {
    return $CacheCoinDetailTable(attachedDatabase, alias);
  }
}

class CacheCoinDetailData extends DataClass
    implements Insertable<CacheCoinDetailData> {
  final String coinId;
  final String payloadJson;
  final DateTime fetchedAt;
  const CacheCoinDetailData({
    required this.coinId,
    required this.payloadJson,
    required this.fetchedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coin_id'] = Variable<String>(coinId);
    map['payload_json'] = Variable<String>(payloadJson);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    return map;
  }

  CacheCoinDetailCompanion toCompanion(bool nullToAbsent) {
    return CacheCoinDetailCompanion(
      coinId: Value(coinId),
      payloadJson: Value(payloadJson),
      fetchedAt: Value(fetchedAt),
    );
  }

  factory CacheCoinDetailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheCoinDetailData(
      coinId: serializer.fromJson<String>(json['coinId']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coinId': serializer.toJson<String>(coinId),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
    };
  }

  CacheCoinDetailData copyWith({
    String? coinId,
    String? payloadJson,
    DateTime? fetchedAt,
  }) => CacheCoinDetailData(
    coinId: coinId ?? this.coinId,
    payloadJson: payloadJson ?? this.payloadJson,
    fetchedAt: fetchedAt ?? this.fetchedAt,
  );
  CacheCoinDetailData copyWithCompanion(CacheCoinDetailCompanion data) {
    return CacheCoinDetailData(
      coinId: data.coinId.present ? data.coinId.value : this.coinId,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheCoinDetailData(')
          ..write('coinId: $coinId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(coinId, payloadJson, fetchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheCoinDetailData &&
          other.coinId == this.coinId &&
          other.payloadJson == this.payloadJson &&
          other.fetchedAt == this.fetchedAt);
}

class CacheCoinDetailCompanion extends UpdateCompanion<CacheCoinDetailData> {
  final Value<String> coinId;
  final Value<String> payloadJson;
  final Value<DateTime> fetchedAt;
  final Value<int> rowid;
  const CacheCoinDetailCompanion({
    this.coinId = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheCoinDetailCompanion.insert({
    required String coinId,
    required String payloadJson,
    required DateTime fetchedAt,
    this.rowid = const Value.absent(),
  }) : coinId = Value(coinId),
       payloadJson = Value(payloadJson),
       fetchedAt = Value(fetchedAt);
  static Insertable<CacheCoinDetailData> custom({
    Expression<String>? coinId,
    Expression<String>? payloadJson,
    Expression<DateTime>? fetchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coinId != null) 'coin_id': coinId,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheCoinDetailCompanion copyWith({
    Value<String>? coinId,
    Value<String>? payloadJson,
    Value<DateTime>? fetchedAt,
    Value<int>? rowid,
  }) {
    return CacheCoinDetailCompanion(
      coinId: coinId ?? this.coinId,
      payloadJson: payloadJson ?? this.payloadJson,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coinId.present) {
      map['coin_id'] = Variable<String>(coinId.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheCoinDetailCompanion(')
          ..write('coinId: $coinId, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  late final $CacheMarketsPagesTable cacheMarketsPages =
      $CacheMarketsPagesTable(this);
  late final $CacheTrendingTable cacheTrending = $CacheTrendingTable(this);
  late final $CacheGlobalTable cacheGlobal = $CacheGlobalTable(this);
  late final $CacheCoinDetailTable cacheCoinDetail = $CacheCoinDetailTable(
    this,
  );
  late final AppDao appDao = AppDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favorites,
    cacheMarketsPages,
    cacheTrending,
    cacheGlobal,
    cacheCoinDetail,
  ];
}

typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      required String coinId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<String> coinId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get coinId =>
      $composableBuilder(column: $table.coinId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> coinId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion(
                coinId: coinId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String coinId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion.insert(
                coinId: coinId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;
typedef $$CacheMarketsPagesTableCreateCompanionBuilder =
    CacheMarketsPagesCompanion Function({
      required int page,
      required String searchQuery,
      required String payloadJson,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$CacheMarketsPagesTableUpdateCompanionBuilder =
    CacheMarketsPagesCompanion Function({
      Value<int> page,
      Value<String> searchQuery,
      Value<String> payloadJson,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$CacheMarketsPagesTableFilterComposer
    extends Composer<_$AppDatabase, $CacheMarketsPagesTable> {
  $$CacheMarketsPagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheMarketsPagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheMarketsPagesTable> {
  $$CacheMarketsPagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get page => $composableBuilder(
    column: $table.page,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheMarketsPagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheMarketsPagesTable> {
  $$CacheMarketsPagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get page =>
      $composableBuilder(column: $table.page, builder: (column) => column);

  GeneratedColumn<String> get searchQuery => $composableBuilder(
    column: $table.searchQuery,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CacheMarketsPagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheMarketsPagesTable,
          CacheMarketsPage,
          $$CacheMarketsPagesTableFilterComposer,
          $$CacheMarketsPagesTableOrderingComposer,
          $$CacheMarketsPagesTableAnnotationComposer,
          $$CacheMarketsPagesTableCreateCompanionBuilder,
          $$CacheMarketsPagesTableUpdateCompanionBuilder,
          (
            CacheMarketsPage,
            BaseReferences<
              _$AppDatabase,
              $CacheMarketsPagesTable,
              CacheMarketsPage
            >,
          ),
          CacheMarketsPage,
          PrefetchHooks Function()
        > {
  $$CacheMarketsPagesTableTableManager(
    _$AppDatabase db,
    $CacheMarketsPagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheMarketsPagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheMarketsPagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheMarketsPagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> page = const Value.absent(),
                Value<String> searchQuery = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheMarketsPagesCompanion(
                page: page,
                searchQuery: searchQuery,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int page,
                required String searchQuery,
                required String payloadJson,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => CacheMarketsPagesCompanion.insert(
                page: page,
                searchQuery: searchQuery,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheMarketsPagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheMarketsPagesTable,
      CacheMarketsPage,
      $$CacheMarketsPagesTableFilterComposer,
      $$CacheMarketsPagesTableOrderingComposer,
      $$CacheMarketsPagesTableAnnotationComposer,
      $$CacheMarketsPagesTableCreateCompanionBuilder,
      $$CacheMarketsPagesTableUpdateCompanionBuilder,
      (
        CacheMarketsPage,
        BaseReferences<
          _$AppDatabase,
          $CacheMarketsPagesTable,
          CacheMarketsPage
        >,
      ),
      CacheMarketsPage,
      PrefetchHooks Function()
    >;
typedef $$CacheTrendingTableCreateCompanionBuilder =
    CacheTrendingCompanion Function({
      Value<int> id,
      required String payloadJson,
      required DateTime fetchedAt,
    });
typedef $$CacheTrendingTableUpdateCompanionBuilder =
    CacheTrendingCompanion Function({
      Value<int> id,
      Value<String> payloadJson,
      Value<DateTime> fetchedAt,
    });

class $$CacheTrendingTableFilterComposer
    extends Composer<_$AppDatabase, $CacheTrendingTable> {
  $$CacheTrendingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheTrendingTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheTrendingTable> {
  $$CacheTrendingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheTrendingTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheTrendingTable> {
  $$CacheTrendingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CacheTrendingTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheTrendingTable,
          CacheTrendingData,
          $$CacheTrendingTableFilterComposer,
          $$CacheTrendingTableOrderingComposer,
          $$CacheTrendingTableAnnotationComposer,
          $$CacheTrendingTableCreateCompanionBuilder,
          $$CacheTrendingTableUpdateCompanionBuilder,
          (
            CacheTrendingData,
            BaseReferences<
              _$AppDatabase,
              $CacheTrendingTable,
              CacheTrendingData
            >,
          ),
          CacheTrendingData,
          PrefetchHooks Function()
        > {
  $$CacheTrendingTableTableManager(_$AppDatabase db, $CacheTrendingTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheTrendingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheTrendingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheTrendingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => CacheTrendingCompanion(
                id: id,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String payloadJson,
                required DateTime fetchedAt,
              }) => CacheTrendingCompanion.insert(
                id: id,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheTrendingTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheTrendingTable,
      CacheTrendingData,
      $$CacheTrendingTableFilterComposer,
      $$CacheTrendingTableOrderingComposer,
      $$CacheTrendingTableAnnotationComposer,
      $$CacheTrendingTableCreateCompanionBuilder,
      $$CacheTrendingTableUpdateCompanionBuilder,
      (
        CacheTrendingData,
        BaseReferences<_$AppDatabase, $CacheTrendingTable, CacheTrendingData>,
      ),
      CacheTrendingData,
      PrefetchHooks Function()
    >;
typedef $$CacheGlobalTableCreateCompanionBuilder =
    CacheGlobalCompanion Function({
      Value<int> id,
      required String payloadJson,
      required DateTime fetchedAt,
    });
typedef $$CacheGlobalTableUpdateCompanionBuilder =
    CacheGlobalCompanion Function({
      Value<int> id,
      Value<String> payloadJson,
      Value<DateTime> fetchedAt,
    });

class $$CacheGlobalTableFilterComposer
    extends Composer<_$AppDatabase, $CacheGlobalTable> {
  $$CacheGlobalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheGlobalTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheGlobalTable> {
  $$CacheGlobalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheGlobalTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheGlobalTable> {
  $$CacheGlobalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CacheGlobalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheGlobalTable,
          CacheGlobalData,
          $$CacheGlobalTableFilterComposer,
          $$CacheGlobalTableOrderingComposer,
          $$CacheGlobalTableAnnotationComposer,
          $$CacheGlobalTableCreateCompanionBuilder,
          $$CacheGlobalTableUpdateCompanionBuilder,
          (
            CacheGlobalData,
            BaseReferences<_$AppDatabase, $CacheGlobalTable, CacheGlobalData>,
          ),
          CacheGlobalData,
          PrefetchHooks Function()
        > {
  $$CacheGlobalTableTableManager(_$AppDatabase db, $CacheGlobalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheGlobalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheGlobalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheGlobalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
              }) => CacheGlobalCompanion(
                id: id,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String payloadJson,
                required DateTime fetchedAt,
              }) => CacheGlobalCompanion.insert(
                id: id,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheGlobalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheGlobalTable,
      CacheGlobalData,
      $$CacheGlobalTableFilterComposer,
      $$CacheGlobalTableOrderingComposer,
      $$CacheGlobalTableAnnotationComposer,
      $$CacheGlobalTableCreateCompanionBuilder,
      $$CacheGlobalTableUpdateCompanionBuilder,
      (
        CacheGlobalData,
        BaseReferences<_$AppDatabase, $CacheGlobalTable, CacheGlobalData>,
      ),
      CacheGlobalData,
      PrefetchHooks Function()
    >;
typedef $$CacheCoinDetailTableCreateCompanionBuilder =
    CacheCoinDetailCompanion Function({
      required String coinId,
      required String payloadJson,
      required DateTime fetchedAt,
      Value<int> rowid,
    });
typedef $$CacheCoinDetailTableUpdateCompanionBuilder =
    CacheCoinDetailCompanion Function({
      Value<String> coinId,
      Value<String> payloadJson,
      Value<DateTime> fetchedAt,
      Value<int> rowid,
    });

class $$CacheCoinDetailTableFilterComposer
    extends Composer<_$AppDatabase, $CacheCoinDetailTable> {
  $$CacheCoinDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheCoinDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheCoinDetailTable> {
  $$CacheCoinDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get coinId => $composableBuilder(
    column: $table.coinId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheCoinDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheCoinDetailTable> {
  $$CacheCoinDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get coinId =>
      $composableBuilder(column: $table.coinId, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);
}

class $$CacheCoinDetailTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheCoinDetailTable,
          CacheCoinDetailData,
          $$CacheCoinDetailTableFilterComposer,
          $$CacheCoinDetailTableOrderingComposer,
          $$CacheCoinDetailTableAnnotationComposer,
          $$CacheCoinDetailTableCreateCompanionBuilder,
          $$CacheCoinDetailTableUpdateCompanionBuilder,
          (
            CacheCoinDetailData,
            BaseReferences<
              _$AppDatabase,
              $CacheCoinDetailTable,
              CacheCoinDetailData
            >,
          ),
          CacheCoinDetailData,
          PrefetchHooks Function()
        > {
  $$CacheCoinDetailTableTableManager(
    _$AppDatabase db,
    $CacheCoinDetailTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheCoinDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheCoinDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheCoinDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> coinId = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheCoinDetailCompanion(
                coinId: coinId,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String coinId,
                required String payloadJson,
                required DateTime fetchedAt,
                Value<int> rowid = const Value.absent(),
              }) => CacheCoinDetailCompanion.insert(
                coinId: coinId,
                payloadJson: payloadJson,
                fetchedAt: fetchedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheCoinDetailTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheCoinDetailTable,
      CacheCoinDetailData,
      $$CacheCoinDetailTableFilterComposer,
      $$CacheCoinDetailTableOrderingComposer,
      $$CacheCoinDetailTableAnnotationComposer,
      $$CacheCoinDetailTableCreateCompanionBuilder,
      $$CacheCoinDetailTableUpdateCompanionBuilder,
      (
        CacheCoinDetailData,
        BaseReferences<
          _$AppDatabase,
          $CacheCoinDetailTable,
          CacheCoinDetailData
        >,
      ),
      CacheCoinDetailData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
  $$CacheMarketsPagesTableTableManager get cacheMarketsPages =>
      $$CacheMarketsPagesTableTableManager(_db, _db.cacheMarketsPages);
  $$CacheTrendingTableTableManager get cacheTrending =>
      $$CacheTrendingTableTableManager(_db, _db.cacheTrending);
  $$CacheGlobalTableTableManager get cacheGlobal =>
      $$CacheGlobalTableTableManager(_db, _db.cacheGlobal);
  $$CacheCoinDetailTableTableManager get cacheCoinDetail =>
      $$CacheCoinDetailTableTableManager(_db, _db.cacheCoinDetail);
}
