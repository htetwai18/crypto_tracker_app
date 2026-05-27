part of 'coin_list_bloc.dart';

final class CoinListState extends Equatable {
  const CoinListState({
    this.isInitialLoading = true,
    this.isSearching = false,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    this.coins = const [],
    this.trending = const [],
    this.global,
    this.favoriteIds = const {},
    this.errorMessage,
    this.currentPage = 0,
    this.searchQuery = '',
    this.offlineBanner = false,
    this.hasMore = true,
    this.emptySearch = false,
    this.loadMoreBlockedUntil,
    this.actionMessage,
    this.cachedMarketsFetchedAt,
  });

  final bool isInitialLoading;
  final bool isSearching;
  final bool isLoadingMore;
  final bool isRefreshing;
  final List<CoinSummary> coins;
  final List<TrendingCoin> trending;
  final GlobalMarketOverview? global;
  final Set<String> favoriteIds;
  final String? errorMessage;

  /// Last successfully loaded page (starts at 1 after first fetch).
  final int currentPage;
  final String searchQuery;
  final bool offlineBanner;
  final bool hasMore;
  final bool emptySearch;
  final DateTime? loadMoreBlockedUntil;
  final String? actionMessage;
  final DateTime? cachedMarketsFetchedAt;

  bool get canLoadMore {
    if (!hasMore || isLoadingMore || isInitialLoading || isSearching) {
      return false;
    }
    final blockedUntil = loadMoreBlockedUntil;
    if (blockedUntil == null) return true;
    return DateTime.now().isAfter(blockedUntil);
  }

  CoinListState copyWith({
    bool? isInitialLoading,
    bool? isSearching,
    bool? isLoadingMore,
    bool? isRefreshing,
    List<CoinSummary>? coins,
    List<TrendingCoin>? trending,
    GlobalMarketOverview? global,
    Set<String>? favoriteIds,
    String? errorMessage,
    bool clearErrorMessage = false,
    int? currentPage,
    String? searchQuery,
    bool? offlineBanner,
    bool? hasMore,
    bool? emptySearch,
    DateTime? loadMoreBlockedUntil,
    bool clearLoadMoreBlockedUntil = false,
    String? actionMessage,
    bool clearActionMessage = false,
    DateTime? cachedMarketsFetchedAt,
    bool clearCachedMarketsFetchedAt = false,
  }) {
    return CoinListState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isSearching: isSearching ?? this.isSearching,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      coins: coins ?? this.coins,
      trending: trending ?? this.trending,
      global: global ?? this.global,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
      offlineBanner: offlineBanner ?? this.offlineBanner,
      hasMore: hasMore ?? this.hasMore,
      emptySearch: emptySearch ?? this.emptySearch,
      loadMoreBlockedUntil: clearLoadMoreBlockedUntil
          ? null
          : (loadMoreBlockedUntil ?? this.loadMoreBlockedUntil),
      actionMessage: clearActionMessage
          ? null
          : (actionMessage ?? this.actionMessage),
      cachedMarketsFetchedAt: clearCachedMarketsFetchedAt
          ? null
          : (cachedMarketsFetchedAt ?? this.cachedMarketsFetchedAt),
    );
  }

  @override
  List<Object?> get props => [
    isInitialLoading,
    isSearching,
    isLoadingMore,
    isRefreshing,
    coins,
    trending,
    global,
    favoriteIds,
    errorMessage,
    currentPage,
    searchQuery,
    offlineBanner,
    hasMore,
    emptySearch,
    loadMoreBlockedUntil,
    actionMessage,
    cachedMarketsFetchedAt,
  ];
}
