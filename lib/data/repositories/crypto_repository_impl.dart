import 'dart:convert';

import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/error/failures.dart';
import '../../core/network/dio_failure_mapper.dart';
import '../../core/network/network_info.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/coin_detail.dart';
import '../../domain/entities/coin_summary.dart';
import '../../domain/entities/global_market_overview.dart';
import '../../domain/entities/trending_coin.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/local/coin_local_datasource.dart';
import '../datasources/remote/coin_remote_datasource.dart';
import '../models/coin_detail_dto.dart';
import '../models/coin_market_dto.dart';
import '../models/global_market_dto.dart';
import '../models/trending_response_dto.dart';

final class CryptoRepositoryImpl implements CryptoRepository {
  CryptoRepositoryImpl({
    required NetworkInfo networkInfo,
    required CoinRemoteDataSource remote,
    required CoinLocalDataSource local,
  }) : _networkInfo = networkInfo,
       _remote = remote,
       _local = local;

  final NetworkInfo _networkInfo;
  final CoinRemoteDataSource _remote;
  final CoinLocalDataSource _local;

  String _normSearch(String q) => q.trim().toLowerCase();
  bool _isFresh(DateTime? fetchedAt, Duration ttl) {
    if (fetchedAt == null) return false;
    return DateTime.now().difference(fetchedAt) <= ttl;
  }

  @override
  Stream<Set<String>> watchFavoriteIds() => _local.watchFavoriteIds();

  @override
  Future<bool> isFavorite(String coinId) => _local.isFavorite(coinId);

  @override
  Future<Result<bool>> setFavorite({
    required String coinId,
    required bool favorite,
  }) async {
    try {
      await _local.setFavorite(coinId: coinId, favorite: favorite);
      return const Ok(true);
    } catch (_) {
      return const Err(CacheFailure());
    }
  }

  @override
  Future<void> clearMarketsCache() => _local.clearMarketsCache();

  @override
  Future<DateTime?> getMarketsCacheFetchedAt({
    required int page,
    String searchQuery = '',
  }) {
    return _local.cachedMarketsPageFetchedAt(
      page: page,
      normalizedSearchQuery: _normSearch(searchQuery),
    );
  }

  List<CoinMarketDto>? _decodeMarketsCached(String? json) {
    if (json == null || json.isEmpty) return null;
    try {
      return CoinMarketDto.decodeListFromJsonString(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<Result<List<CoinSummary>>> getMarketsPage({
    required int page,
    int perPage = ApiConstants.defaultPerPage,
    String searchQuery = '',
    bool forceRemote = false,
  }) async {
    final key = _normSearch(searchQuery);
    final online = await _networkInfo.isConnected;

    Future<Result<List<CoinSummary>>> loadFromDisk() async {
      final cached = await _local.cachedMarketsPage(
        page: page,
        normalizedSearchQuery: key,
      );
      final dtos = _decodeMarketsCached(cached);
      if (dtos == null) {
        final msg = online
            ? 'Could not refresh markets.'
            : 'No network connection and no cached data for this screen.';
        return Err(NetworkUnavailableFailure(message: msg));
      }
      return Ok(dtos.map((dto) => dto.toEntity()).toList(growable: false));
    }

    if (!forceRemote) {
      final fetchedAt = await _local.cachedMarketsPageFetchedAt(
        page: page,
        normalizedSearchQuery: key,
      );
      if (_isFresh(fetchedAt, ApiConstants.marketsCacheTtl)) {
        final cached = await loadFromDisk();
        if (cached.isOk) return cached;
      }
    }

    if (!online) return loadFromDisk();

    Future<void> persistDtos(List<CoinMarketDto> dtos) async {
      final raw = dtos
          .map(
            (dto) => {
              'id': dto.id,
              'symbol': dto.symbol.toLowerCase(),
              'name': dto.name,
              'image': dto.image,
              'current_price': dto.currentPrice,
              'price_change_percentage_24h': dto.priceChangePct24h,
              'market_cap': dto.marketCap,
              'market_cap_rank': dto.marketCapRank,
            },
          )
          .toList();
      await _local.persistMarketsPage(
        page: page,
        normalizedSearchQuery: key,
        payloadJson: jsonEncode(raw),
      );
    }

    try {
      late List<CoinMarketDto> dtos;
      if (key.isEmpty) {
        final rows = await _remote.fetchMarketsPage(
          page: page,
          perPage: perPage,
        );
        dtos = CoinMarketDto.decodeList(rows);
      } else {
        final idsAll = await _remote.searchCoinIds(searchQuery);
        final start = (page - 1) * perPage;
        if (start >= idsAll.length) {
          await persistDtos([]);
          return const Ok([]);
        }
        final chunk = idsAll.skip(start).take(perPage).toList(growable: false);
        final rows = chunk.isEmpty
            ? const []
            : await _remote.fetchMarketsForIds(chunk);
        dtos = CoinMarketDto.decodeList(rows);
      }

      await persistDtos(dtos);
      return Ok(dtos.map((e) => e.toEntity()).toList(growable: false));
    } on DioException catch (e) {
      final cached = await loadFromDisk();
      if (cached.isOk) return cached;
      return Err(failureFromDio(e));
    } catch (_) {
      final cached = await loadFromDisk();
      if (cached.isOk) return cached;
      return const Err(ServerFailure());
    }
  }

  @override
  Future<Result<(GlobalMarketOverview?, List<TrendingCoin>)>>
  getTrendingAndGlobal({bool forceRemote = false}) async {
    final online = await _networkInfo.isConnected;

    Future<Result<(GlobalMarketOverview?, List<TrendingCoin>)>>
    loadCombinedFromDisk() async {
      final gJson = await _local.cachedGlobalJson();
      final tJson = await _local.cachedTrendingJson();
      final global = gJson != null
          ? GlobalMarketDto.tryDecode(gJson)?.toEntityOrNull()
          : null;
      final trendingRaw = tJson != null
          ? TrendingResponseDto.tryDecode(tJson)
          : null;
      final trending = trendingRaw?.toTrendingCoins() ?? <TrendingCoin>[];
      if (global == null && trending.isEmpty) {
        return Err(
          NetworkUnavailableFailure(
            message: online
                ? 'Could not refresh header data.'
                : 'No cached global / trending snapshots yet.',
          ),
        );
      }
      return Ok((global, trending));
    }

    if (!forceRemote) {
      final globalFetchedAt = await _local.cachedGlobalFetchedAt();
      final trendingFetchedAt = await _local.cachedTrendingFetchedAt();
      final isFreshCombined =
          _isFresh(globalFetchedAt, ApiConstants.trendingGlobalCacheTtl) &&
          _isFresh(trendingFetchedAt, ApiConstants.trendingGlobalCacheTtl);
      if (isFreshCombined) {
        final disk = await loadCombinedFromDisk();
        if (disk.isOk) return disk;
      }
    }

    if (!online) return loadCombinedFromDisk();

    try {
      final rawGlobal = await _remote.fetchGlobal();
      final rawTrending = await _remote.fetchTrending();
      await _local.persistGlobalJson(jsonEncode(rawGlobal));
      await _local.persistTrendingJson(jsonEncode(rawTrending));

      final global = GlobalMarketDto.fromJson(rawGlobal).toEntityOrNull();
      final trending = TrendingResponseDto.fromJson(
        rawTrending,
      ).toTrendingCoins();

      return Ok((global, trending));
    } on DioException catch (e) {
      final disk = await loadCombinedFromDisk();
      if (disk.isOk) return disk;
      return Err(failureFromDio(e));
    } catch (_) {
      final disk = await loadCombinedFromDisk();
      if (disk.isOk) return disk;
      return const Err(ServerFailure());
    }
  }

  @override
  Future<Result<CoinDetail>> getCoinDetail(
    String coinId, {
    bool forceRemote = false,
  }) async {
    Future<Result<CoinDetail>> fromDisk(String id) async {
      final json = await _local.cachedCoinDetailJson(id);
      if (json != null) {
        final dto = CoinDetailDto.tryDecode(json);
        if (dto != null) return Ok(dto.toEntity());
      }
      final msg = await _networkInfo.isConnected
          ? 'Coin details unavailable.'
          : 'Offline and this coin has not been cached yet.';
      return Err(NetworkUnavailableFailure(message: msg));
    }

    final online = await _networkInfo.isConnected;

    if (!forceRemote) {
      final fetchedAt = await _local.cachedCoinDetailFetchedAt(coinId);
      if (_isFresh(fetchedAt, ApiConstants.coinDetailCacheTtl)) {
        final cached = await fromDisk(coinId);
        if (cached.isOk) return cached;
      }
    }

    if (!online) return fromDisk(coinId);

    try {
      final raw = await _remote.fetchCoinDetail(coinId);
      await _local.persistCoinDetailJson(coinId, jsonEncode(raw));
      final detail = CoinDetailDto.fromJson(raw).toEntity();
      return Ok(detail);
    } on DioException catch (e) {
      final fb = await fromDisk(coinId);
      if (fb.isOk) return fb;
      return Err(failureFromDio(e));
    } catch (_) {
      final fb = await fromDisk(coinId);
      if (fb.isOk) return fb;
      return const Err(ServerFailure());
    }
  }
}
