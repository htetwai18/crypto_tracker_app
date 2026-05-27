import 'package:bloc_test/bloc_test.dart';
import 'package:crypto_tracker_app/core/error/failures.dart';
import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/coin_detail.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/domain/usecases/get_coin_detail_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/toggle_favorite_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/watch_favorite_ids_use_case.dart';
import 'package:crypto_tracker_app/presentation/coin_detail/bloc/coin_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_crypto_repository.dart';

void main() {
  late StubCryptoRepository repo;

  const summary = CoinSummary(
    id: 'eth',
    symbol: 'ETH',
    name: 'Ethereum',
    imageUrl: '',
    currentPriceUsd: 3000,
    priceChangePercentage24h: 1.2,
    marketCapUsd: 100,
    marketCapRank: 2,
  );

  setUp(() {
    repo = StubCryptoRepository(
      favoritesStream: Stream<Set<String>>.value(<String>{}),
    );
    repo.detailAnswer = (coinId, {forceRemote = false}) async => Ok(
      CoinDetail(
        summary: summary,
        descriptions: const {'en': 'Smart contracts platform'},
      ),
    );
  });

  CoinDetailBloc buildBloc() => CoinDetailBloc(
    coinId: 'eth',
    watchFavoriteIds: WatchFavoriteIdsUseCase(repo),
    getCoinDetailUseCase: GetCoinDetailUseCase(repo),
    toggleFavoriteUseCase: ToggleFavoriteUseCase(repo),
  );

  blocTest<CoinDetailBloc, CoinDetailState>(
    'loads detail on start',
    build: buildBloc,
    wait: const Duration(milliseconds: 50),
    verify: (bloc) {
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.detail?.summary.symbol, 'ETH');
      expect(
        bloc.state.detail?.descriptionFor('en'),
        'Smart contracts platform',
      );
    },
  );

  blocTest<CoinDetailBloc, CoinDetailState>(
    'emits action message when favorite toggle fails',
    build: () {
      repo.setFavoriteAnswer = ({required coinId, required favorite}) async =>
          const Err(CacheFailure(message: 'Favorite failed'));
      return buildBloc();
    },
    wait: const Duration(milliseconds: 50),
    act: (bloc) async {
      bloc.add(const CoinDetailFavoritePressed());
      await Future<void>.delayed(const Duration(milliseconds: 20));
    },
    verify: (bloc) {
      expect(bloc.state.actionMessage, 'Favorite failed');
    },
  );

  blocTest<CoinDetailBloc, CoinDetailState>(
    'refresh clears transient failure message after recovery',
    build: () {
      var callCount = 0;
      repo.detailAnswer = (coinId, {forceRemote = false}) async {
        callCount++;
        if (callCount == 1) {
          return const Err(ServerFailure(message: 'Load failed'));
        }
        return Ok(
          CoinDetail(summary: summary, descriptions: const {'en': 'Recovered'}),
        );
      };
      return buildBloc();
    },
    wait: const Duration(milliseconds: 50),
    act: (bloc) async {
      await Future<void>.delayed(const Duration(milliseconds: 60));
      bloc.add(const CoinDetailRefreshed());
      await Future<void>.delayed(const Duration(milliseconds: 60));
    },
    verify: (bloc) {
      expect(bloc.state.failureMessage, isNull);
      expect(bloc.state.detail?.descriptionFor('en'), 'Recovered');
      expect(bloc.state.isLoading, isFalse);
    },
  );

  blocTest<CoinDetailBloc, CoinDetailState>(
    'refresh clears stale action message',
    build: () {
      repo.setFavoriteAnswer = ({required coinId, required favorite}) async =>
          const Err(CacheFailure(message: 'Favorite failed'));
      return buildBloc();
    },
    wait: const Duration(milliseconds: 50),
    act: (bloc) async {
      bloc.add(const CoinDetailFavoritePressed());
      await Future<void>.delayed(const Duration(milliseconds: 20));
      bloc.add(const CoinDetailRefreshed());
      await Future<void>.delayed(const Duration(milliseconds: 60));
    },
    verify: (bloc) {
      expect(bloc.state.actionMessage, isNull);
      expect(bloc.state.isLoading, isFalse);
    },
  );
}
