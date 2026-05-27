import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/coin_detail.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/domain/entities/global_market_overview.dart';
import 'package:crypto_tracker_app/domain/entities/trending_coin.dart';
import 'package:crypto_tracker_app/domain/repositories/crypto_repository.dart';

/// Minimal stub for tests — override [marketsAnswer] as needed.
final class StubCryptoRepository implements CryptoRepository {
  StubCryptoRepository({
    this.marketsAnswer,
    Stream<Set<String>>? favoritesStream,
  }) : _favoritesStream =
           favoritesStream ?? Stream<Set<String>>.value(<String>{});

  Future<Result<List<CoinSummary>>> Function({
    required int page,
    int perPage,
    String searchQuery,
    bool forceRemote,
  })? marketsAnswer;

  Future<Result<CoinDetail>> Function(
    String coinId, {
    bool forceRemote,
  })? detailAnswer;
  Future<Result<bool>> Function({
    required String coinId,
    required bool favorite,
  })? setFavoriteAnswer;

  int clearMarketsCacheCalls = 0;
  DateTime? marketsCacheFetchedAt;

  final Stream<Set<String>> _favoritesStream;

  @override
  Future<void> clearMarketsCache() async {
    clearMarketsCacheCalls++;
  }

  @override
  Future<DateTime?> getMarketsCacheFetchedAt({
    required int page,
    String searchQuery = '',
  }) async => marketsCacheFetchedAt;

  @override
  Future<bool> isFavorite(String coinId) async => false;

  @override
  Future<Result<CoinDetail>> getCoinDetail(
    String coinId, {
    bool forceRemote = false,
  }) =>
      detailAnswer?.call(coinId, forceRemote: forceRemote) ??
      Future.value(Err(ServerFailure(message: 'unused in stub')));

  @override
  Future<Result<List<CoinSummary>>> getMarketsPage({
    required int page,
    int perPage = 20,
    String searchQuery = '',
    bool forceRemote = false,
  }) =>
      marketsAnswer?.call(
        page: page,
        perPage: perPage,
        searchQuery: searchQuery,
        forceRemote: forceRemote,
      ) ??
      Future.value(const Ok(<CoinSummary>[]));

  @override
  Future<Result<(GlobalMarketOverview?, List<TrendingCoin>)>>
  getTrendingAndGlobal({bool forceRemote = false}) async {
    const GlobalMarketOverview? g = null;
    return Ok((g, const <TrendingCoin>[]));
  }

  @override
  Future<Result<bool>> setFavorite({
    required String coinId,
    required bool favorite,
  }) =>
      setFavoriteAnswer?.call(coinId: coinId, favorite: favorite) ??
      Future.value(const Ok(true));

  @override
  Stream<Set<String>> watchFavoriteIds() => _favoritesStream;
}
