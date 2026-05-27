part of 'coin_detail_bloc.dart';

sealed class CoinDetailEvent extends Equatable {
  const CoinDetailEvent();

  @override
  List<Object?> get props => [];
}

final class CoinDetailStarted extends CoinDetailEvent {
  const CoinDetailStarted();
}

final class CoinDetailRefreshed extends CoinDetailEvent {
  const CoinDetailRefreshed();
}

final class CoinDetailFavoritePressed extends CoinDetailEvent {
  const CoinDetailFavoritePressed();
}

final class CoinDetailFavoriteIdsEmitted extends CoinDetailEvent {
  const CoinDetailFavoriteIdsEmitted(this.ids);

  final Set<String> ids;

  @override
  List<Object?> get props => [ids];
}
