import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/domain/usecases/clear_markets_cache_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_cache_fetched_at_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_page_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_trending_and_global_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/toggle_favorite_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/watch_favorite_ids_use_case.dart';
import 'package:crypto_tracker_app/presentation/coin_list/bloc/coin_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_crypto_repository.dart';
import '../fakes/stub_network_info.dart';

void main() {
  late StubCryptoRepository repo;
  late StubNetworkInfo networkInfo;

  setUp(() {
    repo = StubCryptoRepository(
      favoritesStream: Stream<Set<String>>.value(<String>{}),
    );
    networkInfo = StubNetworkInfo(online: true);
    repo.marketsAnswer =
        ({
          required int page,
          perPage = 20,
          searchQuery = '',
          forceRemote = false,
        }) async {
          if (page == 1) {
            return Ok(<CoinSummary>[
              CoinSummary(
                id: 'eth',
                symbol: 'ETH',
                name: 'Ethereum',
                imageUrl: '',
                currentPriceUsd: 3000,
                priceChangePercentage24h: null,
                marketCapUsd: null,
                marketCapRank: 2,
              ),
            ]);
          }
          return const Ok(<CoinSummary>[]);
        };
  });

  CoinListBloc buildBloc() => CoinListBloc(
    watchFavoriteIds: WatchFavoriteIdsUseCase(repo),
    getTrendingAndGlobalUseCase: GetTrendingAndGlobalUseCase(repo),
    getMarketsPageUseCase: GetMarketsPageUseCase(repo),
    getMarketsCacheFetchedAtUseCase: GetMarketsCacheFetchedAtUseCase(repo),
    toggleFavoriteUseCase: ToggleFavoriteUseCase(repo),
    clearMarketsCacheUseCase: ClearMarketsCacheUseCase(repo),
    networkInfo: networkInfo,
  );

  blocTest<CoinListBloc, CoinListState>(
    'emits populated list after CoinListOpened',
    build: buildBloc,
    act: (bloc) => bloc.add(const CoinListOpened()),
    wait: const Duration(milliseconds: 80),
    verify: (bloc) {
      expect(bloc.state.isInitialLoading, isFalse);
      expect(bloc.state.coins, hasLength(1));
      expect(bloc.state.coins.first.symbol, 'ETH');
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'refresh clears transient action message',
    build: () {
      repo.setFavoriteAnswer = ({required coinId, required favorite}) async =>
          const Err(CacheFailure(message: 'Favorite failed'));
      return buildBloc();
    },
    act: (bloc) async {
      bloc.add(const CoinListOpened());
      await Future<void>.delayed(const Duration(milliseconds: 80));
      bloc.add(const CoinListFavoritePressed('eth'));
      await Future<void>.delayed(const Duration(milliseconds: 30));
      bloc.add(const CoinListRefreshRequested());
      await Future<void>.delayed(const Duration(milliseconds: 80));
    },
    verify: (bloc) {
      expect(bloc.state.actionMessage, isNull);
      expect(bloc.state.isRefreshing, isFalse);
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'emits action message when favorite toggle fails',
    build: () {
      repo.setFavoriteAnswer = ({required coinId, required favorite}) async =>
          const Err(CacheFailure(message: 'Favorite failed'));
      return buildBloc();
    },
    act: (bloc) async {
      bloc.add(const CoinListOpened());
      await Future<void>.delayed(const Duration(milliseconds: 80));
      bloc.add(const CoinListFavoritePressed('eth'));
      await Future<void>.delayed(const Duration(milliseconds: 20));
    },
    verify: (bloc) {
      expect(bloc.state.actionMessage, 'Favorite failed');
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'sets cache timestamp after successful initial load',
    build: () {
      repo.marketsCacheFetchedAt = DateTime(2026, 1, 1, 10, 0);
      return buildBloc();
    },
    act: (bloc) => bloc.add(const CoinListOpened()),
    wait: const Duration(milliseconds: 80),
    verify: (bloc) {
      expect(bloc.state.cachedMarketsFetchedAt, isNotNull);
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'shows offline banner when connectivity is lost',
    build: buildBloc,
    act: (bloc) async {
      networkInfo.setOnline(false);
      await Future<void>.delayed(const Duration(milliseconds: 50));
    },
    verify: (bloc) {
      expect(bloc.state.offlineBanner, isTrue);
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'hides offline banner when connectivity returns',
    build: buildBloc,
    act: (bloc) async {
      networkInfo.setOnline(false);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      networkInfo.setOnline(true);
      await Future<void>.delayed(const Duration(milliseconds: 50));
    },
    verify: (bloc) {
      expect(bloc.state.offlineBanner, isFalse);
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'does not clear cache when refresh is requested offline',
    build: buildBloc,
    act: (bloc) async {
      networkInfo.setOnline(false);
      await Future<void>.delayed(const Duration(milliseconds: 20));
      bloc.add(const CoinListRefreshRequested());
      await Future<void>.delayed(const Duration(milliseconds: 50));
    },
    verify: (bloc) {
      expect(repo.clearMarketsCacheCalls, 0);
      expect(bloc.state.isRefreshing, isFalse);
    },
  );

  blocTest<CoinListBloc, CoinListState>(
    'search reload clears stale action message',
    build: () {
      repo.setFavoriteAnswer = ({required coinId, required favorite}) async =>
          const Err(CacheFailure(message: 'Favorite failed'));
      return buildBloc();
    },
    act: (bloc) async {
      bloc.add(const CoinListOpened());
      await Future<void>.delayed(const Duration(milliseconds: 80));
      bloc.add(const CoinListFavoritePressed('eth'));
      await Future<void>.delayed(const Duration(milliseconds: 20));
      bloc.add(const CoinListSearchQueryChanged('btc'));
      await Future<void>.delayed(const Duration(milliseconds: 500));
    },
    verify: (bloc) {
      expect(bloc.state.actionMessage, isNull);
      expect(bloc.state.searchQuery, 'btc');
    },
  );
}
