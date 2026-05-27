import 'package:equatable/equatable.dart';

final class GlobalMarketOverview extends Equatable {
  const GlobalMarketOverview({
    required this.totalMarketCapUsd,
    required this.totalVolumeUsd24h,
    this.marketCapChangePercentage24h,
  });

  final double totalMarketCapUsd;
  final double totalVolumeUsd24h;
  final double? marketCapChangePercentage24h;

  @override
  List<Object?> get props => [
    totalMarketCapUsd,
    totalVolumeUsd24h,
    marketCapChangePercentage24h,
  ];
}
