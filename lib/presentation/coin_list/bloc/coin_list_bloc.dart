import 'dart:async';
import 'dart:developer' as developer;

import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/constants/api_constants.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/core/network/network_info.dart';
import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/global_market_overview.dart';
import 'package:crypto_tracker_app/domain/entities/trending_coin.dart';
import 'package:crypto_tracker_app/domain/usecases/clear_markets_cache_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_cache_fetched_at_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_page_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_trending_and_global_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/toggle_favorite_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/watch_favorite_ids_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_list_event.dart';
part 'coin_list_state.dart';

class CoinListBloc extends Bloc<CoinListEvent, CoinListState> {
  CoinListBloc({
    required WatchFavoriteIdsUseCase watchFavoriteIds,
    required GetTrendingAndGlobalUseCase getTrendingAndGlobalUseCase,
    required GetMarketsPageUseCase getMarketsPageUseCase,
    required GetMarketsCacheFetchedAtUseCase getMarketsCacheFetchedAtUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
    required ClearMarketsCacheUseCase clearMarketsCacheUseCase,
    required NetworkInfo networkInfo,
  }) : _watchFavoriteIds = watchFavoriteIds,
       _getTrendingAndGlobalUseCase = getTrendingAndGlobalUseCase,
       _getMarketsPageUseCase = getMarketsPageUseCase,
       _getMarketsCacheFetchedAtUseCase = getMarketsCacheFetchedAtUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       _clearMarketsCacheUseCase = clearMarketsCacheUseCase,
       _networkInfo = networkInfo,
       super(const CoinListState()) {
    on<CoinListOpened>(_onOpened);
    on<CoinListRefreshRequested>(_onRefresh);
    on<CoinListLoadMoreRequested>(_onLoadMore);
    on<CoinListSearchQueryChanged>(_onSearchQueryChanged);
    on<CoinListSearchReloadTriggered>(_onSearchReload);
    on<CoinListFavoritePressed>(_onFavoritePressed);
    on<CoinListFavoriteIdsEmitted>(_onFavoriteIdsEmitted);
    on<CoinListConnectivityChanged>(_onConnectivityChanged);

    _favoritesSubscription = _watchFavoriteIds().listen(
      (ids) => add(CoinListFavoriteIdsEmitted(ids)),
    );
    _connectivitySubscription = _networkInfo.onConnectivityChanged.listen(
      (online) => add(CoinListConnectivityChanged(online)),
    );
  }

  final WatchFavoriteIdsUseCase _watchFavoriteIds;
  final GetTrendingAndGlobalUseCase _getTrendingAndGlobalUseCase;
  final GetMarketsPageUseCase _getMarketsPageUseCase;
  final GetMarketsCacheFetchedAtUseCase _getMarketsCacheFetchedAtUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;
  final ClearMarketsCacheUseCase _clearMarketsCacheUseCase;
  final NetworkInfo _networkInfo;

  Timer? _searchDebounceTimer;
  late final StreamSubscription<Set<String>> _favoritesSubscription;
  late final StreamSubscription<bool> _connectivitySubscription;

  static const _loadMoreCooldown = Duration(seconds: 45);

  DateTime? _loadMoreBlockedUntil(Failure failure) {
    if (failure is RateLimitFailure) {
      return DateTime.now().add(_loadMoreCooldown);
    }
    return null;
  }

  Future<void> _onOpened(CoinListOpened event, Emitter<CoinListState> emit) =>
      _loadTrendingPlusMarkets(emit, remoteMarketsPreferred: false);

  void _onConnectivityChanged(
    CoinListConnectivityChanged event,
    Emitter<CoinListState> emit,
  ) {
    final offline = !event.isOnline;
    if (state.offlineBanner != offline) {
      emit(state.copyWith(offlineBanner: offline));
    }
  }

  Future<void> _onRefresh(
    CoinListRefreshRequested event,
    Emitter<CoinListState> emit,
  ) async {
    if (state.offlineBanner) return;

    emit(
      state.copyWith(
        isRefreshing: true,
        clearErrorMessage: true,
        clearActionMessage: true,
        clearLoadMoreBlockedUntil: true,
      ),
    );
    await _clearMarketsCacheUseCase();
    await _loadTrendingPlusMarkets(emit, remoteMarketsPreferred: true);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _loadTrendingPlusMarkets(
    Emitter<CoinListState> emit, {
    required bool remoteMarketsPreferred,
  }) async {
    emit(
      state.copyWith(
        isInitialLoading: true,
        clearErrorMessage: true,
        clearActionMessage: true,
        coins: const [],
        currentPage: 0,
        hasMore: true,
        emptySearch: false,
        clearCachedMarketsFetchedAt: true,
      ),
    );

    final online = await _networkInfo.isConnected;
    GlobalMarketOverview? global;
    var trending = <TrendingCoin>[];

    final header = await _getTrendingAndGlobalUseCase(
      forceRemote: remoteMarketsPreferred,
    );

    header.fold((_) {}, (pair) {
      global = pair.$1;
      trending = pair.$2;
    });

    await _finishMarketsPage(
      emit,
      page: 1,
      initialPage: true,
      globalSnapshot: global,
      trendingSnapshot: trending,
      online: online,
      forceRemoteMarkets: online && remoteMarketsPreferred,
      searchQuery: state.searchQuery,
    );
  }

  Future<void> _finishMarketsPage(
    Emitter<CoinListState> emit, {
    required int page,
    required bool initialPage,
    required GlobalMarketOverview? globalSnapshot,
    required List<TrendingCoin> trendingSnapshot,
    required bool online,
    required bool forceRemoteMarkets,
    required String searchQuery,
  }) async {
    final mk = await _getMarketsPageUseCase(
      page: page,
      perPage: ApiConstants.defaultPerPage,
      searchQuery: searchQuery,
      forceRemote: forceRemoteMarkets,
    );

    if (emit.isDone) return;

    final cachedFetchedAt = mk.isOk
        ? await _getMarketsCacheFetchedAtUseCase(
            page: page,
            searchQuery: searchQuery,
          )
        : null;

    mk.fold(
      (failure) {
        emit(
          state.copyWith(
            isInitialLoading: initialPage ? false : state.isInitialLoading,
            isSearching: false,
            isLoadingMore: false,
            global: globalSnapshot,
            trending: trendingSnapshot,
            errorMessage: failure.message,
            loadMoreBlockedUntil: _loadMoreBlockedUntil(failure),
            clearCachedMarketsFetchedAt: initialPage,
          ),
        );
      },
      (list) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            isSearching: false,
            isLoadingMore: false,
            global: globalSnapshot,
            trending: trendingSnapshot,
            coins: initialPage ? list : state.coins,
            currentPage: initialPage ? 1 : state.currentPage,
            hasMore: list.length >= ApiConstants.defaultPerPage,
            clearErrorMessage: true,
            emptySearch:
                searchQuery.trim().isNotEmpty && initialPage && list.isEmpty,
            clearLoadMoreBlockedUntil: true,
            clearActionMessage: true,
            cachedMarketsFetchedAt: initialPage
                ? cachedFetchedAt
                : state.cachedMarketsFetchedAt,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMore(
    CoinListLoadMoreRequested event,
    Emitter<CoinListState> emit,
  ) async {
    if (state.isInitialLoading ||
        state.isSearching ||
        state.isLoadingMore ||
        !state.canLoadMore) {
      return;
    }

    emit(
      state.copyWith(
        isLoadingMore: true,
        clearErrorMessage: true,
        clearActionMessage: true,
      ),
    );
    final nextPage = state.currentPage + 1;

    developer.log(
      'Home pagination: loading page $nextPage '
      '(perPage=${ApiConstants.defaultPerPage}, '
      'search="${state.searchQuery.trim()}")',
      name: 'CoinListBloc',
    );

    final mk = await _getMarketsPageUseCase(
      page: nextPage,
      perPage: ApiConstants.defaultPerPage,
      searchQuery: state.searchQuery,
      forceRemote: false,
    );

    mk.fold(
      (failure) {
        developer.log(
          'Home pagination: page $nextPage failed — ${failure.message}',
          name: 'CoinListBloc',
        );
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: failure.message,
            loadMoreBlockedUntil: _loadMoreBlockedUntil(failure),
          ),
        );
      },
      (list) {
        if (list.isEmpty) {
          developer.log(
            'Home pagination: page $nextPage returned no coins (end of list)',
            name: 'CoinListBloc',
          );
          emit(state.copyWith(isLoadingMore: false, hasMore: false));
          return;
        }

        final seen = state.coins.map((c) => c.id).toSet();
        final appended = [
          ...state.coins,
          ...list.where((c) => !seen.contains(c.id)),
        ];

        developer.log(
          'Home pagination: page $nextPage loaded ${list.length} coins '
          '(${appended.length - state.coins.length} new, '
          'total=${appended.length})',
          name: 'CoinListBloc',
        );

        emit(
          state.copyWith(
            coins: appended,
            currentPage: nextPage,
            isLoadingMore: false,
            hasMore: list.length >= ApiConstants.defaultPerPage,
            clearErrorMessage: true,
            clearLoadMoreBlockedUntil: true,
          ),
        );
      },
    );
  }

  void _onSearchQueryChanged(
    CoinListSearchQueryChanged event,
    Emitter<CoinListState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(
      const Duration(milliseconds: 400),
      () => add(CoinListSearchReloadTriggered(event.query)),
    );
  }

  Future<void> _onSearchReload(
    CoinListSearchReloadTriggered event,
    Emitter<CoinListState> emit,
  ) async {
    final query = event.query.trim();

    emit(
      state.copyWith(
        isSearching: true,
        searchQuery: query,
        coins: const [],
        clearErrorMessage: true,
        clearActionMessage: true,
        currentPage: 0,
        hasMore: true,
        emptySearch: false,
      ),
    );

    try {
      final online = await _networkInfo.isConnected;
      if (emit.isDone) return;

      await _finishMarketsPage(
        emit,
        page: 1,
        initialPage: true,
        globalSnapshot: state.global,
        trendingSnapshot: state.trending,
        online: online,
        forceRemoteMarkets: false,
        searchQuery: query,
      );
    } finally {
      if (!emit.isDone && state.isSearching) {
        emit(state.copyWith(isSearching: false));
      }
    }
  }

  Future<void> _onFavoritePressed(
    CoinListFavoritePressed event,
    Emitter<CoinListState> emit,
  ) async {
    emit(state.copyWith(clearActionMessage: true));
    final toggleOn = !state.favoriteIds.contains(event.coinId);
    final result = await _toggleFavoriteUseCase(
      coinId: event.coinId,
      asFavorite: toggleOn,
    );
    result.fold((failure) {
      emit(state.copyWith(actionMessage: failure.message));
    }, (_) {});
  }

  void _onFavoriteIdsEmitted(
    CoinListFavoriteIdsEmitted event,
    Emitter<CoinListState> emit,
  ) {
    emit(state.copyWith(favoriteIds: event.ids));
  }

  @override
  Future<void> close() {
    _searchDebounceTimer?.cancel();
    _favoritesSubscription.cancel();
    _connectivitySubscription.cancel();
    return super.close();
  }
}
