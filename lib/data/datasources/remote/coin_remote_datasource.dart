import 'dart:developer' as developer;

import 'package:crypto_tracker_app/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

/// Remote CoinGecko access using Dio JSON responses.
abstract interface class CoinRemoteDataSource {
  /// Decoded `/coins/markets` array (possibly empty).
  Future<List<dynamic>> fetchMarketsPage({
    required int page,
    required int perPage,
  });

  Future<List<dynamic>> fetchMarketsForIds(List<String> ids);

  Future<Map<String, dynamic>> fetchGlobal();

  Future<Map<String, dynamic>> fetchTrending();

  Future<Map<String, dynamic>> fetchCoinDetail(String coinId);

  /// CoinGecko `/search` coin ids ordered by relevance (truncated locally).
  Future<List<String>> searchCoinIds(String query, {int maxResults});
}

final class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  CoinRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<dynamic>> fetchMarketsPage({
    required int page,
    required int perPage,
  }) async {
    try {
      final resp = await _dio.get<List<dynamic>>(
        ApiConstants.marketsPath,
        queryParameters: <String, dynamic>{
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': perPage,
          'page': page,
          'sparkline': false,
          'price_change_percentage': '24h',
        },
      );
      return resp.data ?? const [];
    } on DioException catch (e, st) {
      developer.log(
        'fetchMarketsPage failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> fetchMarketsForIds(List<String> ids) async {
    if (ids.isEmpty) return const [];
    final joined = ids.join(',');
    try {
      final resp = await _dio.get<List<dynamic>>(
        ApiConstants.marketsPath,
        queryParameters: <String, dynamic>{
          'vs_currency': 'usd',
          'ids': joined,
          'sparkline': false,
          'price_change_percentage': '24h',
        },
      );
      return resp.data ?? const [];
    } on DioException catch (e, st) {
      developer.log(
        'fetchMarketsForIds failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchGlobal() async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>(ApiConstants.globalPath);
      return resp.data ?? const {};
    } on DioException catch (e, st) {
      developer.log(
        'fetchGlobal failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchTrending() async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>(
        ApiConstants.trendingSearchPath,
      );
      return resp.data ?? const {};
    } on DioException catch (e, st) {
      developer.log(
        'fetchTrending failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> fetchCoinDetail(String coinId) async {
    try {
      final resp = await _dio.get<Map<String, dynamic>>(
        ApiConstants.coinDetailPath(coinId),
        queryParameters: <String, dynamic>{
          'localization': false,
          'tickers': false,
          'market_data': true,
          'community_data': false,
          'developer_data': false,
          'sparkline': false,
        },
      );
      return resp.data ?? const {};
    } on DioException catch (e, st) {
      developer.log(
        'fetchCoinDetail failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  @override
  Future<List<String>> searchCoinIds(String query, {int maxResults = 200}) async {
    final q = query.trim();
    if (q.isEmpty) return const [];

    try {
      final resp = await _dio.get<Map<String, dynamic>>(
        ApiConstants.searchPath,
        queryParameters: <String, dynamic>{'query': q},
      );
      final coins = resp.data?['coins'] as List<dynamic>? ?? const [];
      final ids = <String>[];
      for (final coin in coins) {
        final m = coin as Map<String, dynamic>;
        final id = '${m['id']}';
        if (id.isEmpty) continue;
        ids.add(id);
        if (ids.length >= maxResults) break;
      }
      return ids;
    } on DioException catch (e, st) {
      developer.log(
        'searchCoinIds failed',
        error: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
