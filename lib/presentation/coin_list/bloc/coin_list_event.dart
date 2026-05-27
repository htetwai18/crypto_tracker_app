part of 'coin_list_bloc.dart';

sealed class CoinListEvent extends Equatable {
  const CoinListEvent();

  @override
  List<Object?> get props => [];
}

final class CoinListOpened extends CoinListEvent {
  const CoinListOpened();
}

final class CoinListRefreshRequested extends CoinListEvent {
  const CoinListRefreshRequested();
}

final class CoinListLoadMoreRequested extends CoinListEvent {
  const CoinListLoadMoreRequested();
}

/// Normalized trimmed query (`''` = top market-cap list mode).
final class CoinListSearchQueryChanged extends CoinListEvent {
  const CoinListSearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class CoinListSearchReloadTriggered extends CoinListEvent {
  const CoinListSearchReloadTriggered(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class CoinListFavoritePressed extends CoinListEvent {
  const CoinListFavoritePressed(this.coinId);

  final String coinId;

  @override
  List<Object?> get props => [coinId];
}

final class CoinListFavoriteIdsEmitted extends CoinListEvent {
  const CoinListFavoriteIdsEmitted(this.ids);

  final Set<String> ids;

  @override
  List<Object?> get props => [ids];
}

final class CoinListConnectivityChanged extends CoinListEvent {
  const CoinListConnectivityChanged(this.isOnline);

  final bool isOnline;

  @override
  List<Object?> get props => [isOnline];
}
