import 'dart:async';

import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/coin_detail.dart';
import 'package:crypto_tracker_app/domain/usecases/get_coin_detail_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/toggle_favorite_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/watch_favorite_ids_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_detail_event.dart';
part 'coin_detail_state.dart';

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  CoinDetailBloc({
    required String coinId,
    required WatchFavoriteIdsUseCase watchFavoriteIds,
    required GetCoinDetailUseCase getCoinDetailUseCase,
    required ToggleFavoriteUseCase toggleFavoriteUseCase,
  }) : _coinId = coinId,
       _watchFavoriteIds = watchFavoriteIds,
       _getCoinDetailUseCase = getCoinDetailUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       super(const CoinDetailState()) {
    on<CoinDetailStarted>(_onStarted);
    on<CoinDetailRefreshed>(_onRefreshed);
    on<CoinDetailFavoritePressed>(_onFavoritePressed);
    on<CoinDetailFavoriteIdsEmitted>(_onFavoriteIdsEmitted);

    _favoritesSubscription = _watchFavoriteIds().listen(
      (ids) => add(CoinDetailFavoriteIdsEmitted(ids)),
    );

    add(const CoinDetailStarted());
  }

  final String _coinId;
  final WatchFavoriteIdsUseCase _watchFavoriteIds;
  final GetCoinDetailUseCase _getCoinDetailUseCase;
  final ToggleFavoriteUseCase _toggleFavoriteUseCase;

  late final StreamSubscription<Set<String>> _favoritesSubscription;

  Future<void> _onStarted(
    CoinDetailStarted event,
    Emitter<CoinDetailState> emit,
  ) => _load(emit);

  Future<void> _onRefreshed(
    CoinDetailRefreshed event,
    Emitter<CoinDetailState> emit,
  ) => _load(emit, forceRemote: true);

  Future<void> _load(
    Emitter<CoinDetailState> emit, {
    bool forceRemote = false,
  }) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearFailureMessage: true,
        clearActionMessage: true,
      ),
    );

    final result = await _getCoinDetailUseCase(
      _coinId,
      forceRemote: forceRemote,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            detail: state.detail,
            isLoading: false,
            failureMessage: failure.message,
          ),
        );
      },
      (detail) {
        emit(
          state.copyWith(
            detail: detail,
            isLoading: false,
            clearFailureMessage: true,
          ),
        );
      },
    );
  }

  Future<void> _onFavoritePressed(
    CoinDetailFavoritePressed event,
    Emitter<CoinDetailState> emit,
  ) async {
    emit(state.copyWith(clearActionMessage: true));
    final toggleOn = !state.favoriteIds.contains(_coinId);
    final result = await _toggleFavoriteUseCase(
      coinId: _coinId,
      asFavorite: toggleOn,
    );
    result.fold((failure) {
      emit(state.copyWith(actionMessage: failure.message));
    }, (_) {});
  }

  void _onFavoriteIdsEmitted(
    CoinDetailFavoriteIdsEmitted event,
    Emitter<CoinDetailState> emit,
  ) {
    emit(state.copyWith(favoriteIds: event.ids));
  }

  @override
  Future<void> close() {
    _favoritesSubscription.cancel();
    return super.close();
  }
}
