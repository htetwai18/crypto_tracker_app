import '../entities/coin_detail.dart';
import '../entities/coin_summary.dart';
import '../entities/global_market_overview.dart';
import '../entities/trending_coin.dart';
import '../../core/utils/result.dart';

abstract interface class CryptoRepository {
  Stream<Set<String>> watchFavoriteIds();

  Future<bool> isFavorite(String coinId);

  /// Persists favorites locally (`true` when write succeeded).
  Future<Result<bool>> setFavorite({
    required String coinId,
    required bool favorite,
  });

  /// Paginated `/coins/markets` when [searchQuery] is empty; otherwise search + chunked ids.
  Future<Result<List<CoinSummary>>> getMarketsPage({
    required int page,
    int perPage = 20,
    String searchQuery = '',
    bool forceRemote = false,
  });

  /// Last successful cache timestamp for the keyed markets page.
  Future<DateTime?> getMarketsCacheFetchedAt({
    required int page,
    String searchQuery = '',
  });

  Future<Result<(GlobalMarketOverview?, List<TrendingCoin>)>> getTrendingAndGlobal({
    bool forceRemote = false,
  });

  Future<Result<CoinDetail>> getCoinDetail(
    String coinId, {
    bool forceRemote = false,
  });

  Future<void> clearMarketsCache();
}
