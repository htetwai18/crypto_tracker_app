import 'package:equatable/equatable.dart';

/// List row / markets item.
final class CoinSummary extends Equatable {
  const CoinSummary({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageUrl,
    required this.currentPriceUsd,
    required this.priceChangePercentage24h,
    required this.marketCapUsd,
    required this.marketCapRank,
  });

  final String id;
  final String symbol;
  final String name;
  final String imageUrl;
  final double currentPriceUsd;
  final double? priceChangePercentage24h;
  final double? marketCapUsd;
  final int? marketCapRank;

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    imageUrl,
    currentPriceUsd,
    priceChangePercentage24h,
    marketCapUsd,
    marketCapRank,
  ];
}
