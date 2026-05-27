abstract final class ApiConstants {
  /// CoinGecko v3 REST base (no trailing slash).
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  static const String marketsPath = '/coins/markets';
  static const String globalPath = '/global';
  static const String trendingSearchPath = '/search/trending';
  static const String searchPath = '/search';

  static String coinDetailPath(String coinId) => '/coins/$coinId';

  static const int defaultPerPage = 20;

  /// Max ids per CoinGecko `coins/markets?ids=` request (their limit is fuzzy; keep conservative).
  static const int maxIdsPerMarketRequest = 100;

  /// Cache freshness windows used by repository fetch policy.
  static const Duration marketsCacheTtl = Duration(minutes: 2);
  static const Duration trendingGlobalCacheTtl = Duration(minutes: 10);
  static const Duration coinDetailCacheTtl = Duration(minutes: 20);
}
