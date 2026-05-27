import 'package:equatable/equatable.dart';

final class TrendingCoin extends Equatable {
  const TrendingCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.thumbUrl,
    this.marketCapRank,
    this.priceBtc,
    this.priceChangePercentage24h,
  });

  final String id;
  final String symbol;
  final String name;
  final String thumbUrl;
  final int? marketCapRank;
  final double? priceBtc;
  final double? priceChangePercentage24h;

  @override
  List<Object?> get props => [
    id,
    symbol,
    name,
    thumbUrl,
    marketCapRank,
    priceBtc,
    priceChangePercentage24h,
  ];
}
