part of 'coin_detail_bloc.dart';

final class CoinDetailState extends Equatable {
  const CoinDetailState({
    this.detail,
    this.favoriteIds = const {},
    this.isLoading = true,
    this.failureMessage,
    this.actionMessage,
  });

  final CoinDetail? detail;
  final Set<String> favoriteIds;
  final bool isLoading;
  final String? failureMessage;
  final String? actionMessage;

  CoinDetailState copyWith({
    CoinDetail? detail,
    Set<String>? favoriteIds,
    bool? isLoading,
    String? failureMessage,
    bool clearFailureMessage = false,
    String? actionMessage,
    bool clearActionMessage = false,
  }) {
    return CoinDetailState(
      detail: detail ?? this.detail,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      isLoading: isLoading ?? this.isLoading,
      failureMessage: clearFailureMessage
          ? null
          : (failureMessage ?? this.failureMessage),
      actionMessage: clearActionMessage
          ? null
          : (actionMessage ?? this.actionMessage),
    );
  }

  @override
  List<Object?> get props => [
    detail,
    favoriteIds,
    isLoading,
    failureMessage,
    actionMessage,
  ];
}
