import 'dart:convert';

import '../../domain/entities/coin_summary.dart';

/// `/coins/markets` row.
final class CoinMarketDto {
  const CoinMarketDto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePct24h,
    required this.marketCap,
    required this.marketCapRank,
  });

  factory CoinMarketDto.fromJson(Map<String, dynamic> j) => CoinMarketDto(
    id: j['id'] as String? ?? '',
    symbol: (j['symbol'] as String? ?? '').toUpperCase(),
    name: j['name'] as String? ?? '',
    image: j['image'] as String? ?? '',
    currentPrice: (j['current_price'] as num?)?.toDouble() ?? 0,
    priceChangePct24h: (j['price_change_percentage_24h'] as num?)?.toDouble(),
    marketCap: (j['market_cap'] as num?)?.toDouble(),
    marketCapRank: (j['market_cap_rank'] as num?)?.toInt(),
  );

  /// Raw list from API `data` decoded JSON.
  static List<CoinMarketDto> decodeList(dynamic data) {
    if (data is! List<dynamic>) return const [];
    return data
        .map((e) => CoinMarketDto.fromJson(Map<String, dynamic>.from(e as Map)))
        .where((dto) => dto.id.isNotEmpty)
        .toList();
  }

  static List<CoinMarketDto> decodeListFromJsonString(String payload) =>
      decodeList(jsonDecode(payload) as dynamic);

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double? priceChangePct24h;
  final double? marketCap;
  final int? marketCapRank;

  CoinSummary toEntity() => CoinSummary(
    id: id,
    symbol: symbol,
    name: name,
    imageUrl: image,
    currentPriceUsd: currentPrice,
    priceChangePercentage24h: priceChangePct24h,
    marketCapUsd: marketCap,
    marketCapRank: marketCapRank,
  );
}
