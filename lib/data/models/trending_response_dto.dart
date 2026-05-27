import 'dart:convert';

import '../../domain/entities/trending_coin.dart';

final class TrendingResponseDto {
  TrendingResponseDto._(this.raw);

  final Map<String, dynamic> raw;

  factory TrendingResponseDto.fromJson(Map<String, dynamic> j) =>
      TrendingResponseDto._(j);

  static TrendingResponseDto? tryDecode(String payload) {
    try {
      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      return TrendingResponseDto.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  List<TrendingCoin> toTrendingCoins() {
    final list = raw['coins'] as List<dynamic>? ?? const [];
    return list.map((wrapped) {
      final m = wrapped as Map<String, dynamic>;
      final item = m['item'] as Map<String, dynamic>? ?? m;
      final slug = (item['id'] as String? ?? '').trim();
      final idRaw = item['coin_id'] ?? item['id'];
      final id = slug.isNotEmpty ? slug : '${idRaw ?? ''}'.trim();
      if (id.isEmpty) return null;
      return TrendingCoin(
        id: id,
        symbol: (item['symbol'] as String? ?? '').toUpperCase(),
        name: item['name'] as String? ?? '',
        thumbUrl:
            '${item['small'] ?? item['thumb'] ?? item['large'] ?? ''}',
        marketCapRank: (item['market_cap_rank'] as num?)?.toInt(),
        priceBtc: _parsePriceBtc(item),
        priceChangePercentage24h: _parsePriceChangePercentage24h(item),
      );
    }).whereType<TrendingCoin>().toList();
  }

  static double? _parsePriceBtc(Map<String, dynamic> item) {
    final data = item['data'] as Map<String, dynamic>?;
    final raw = data?['price_btc'] ?? item['price_btc'];
    if (raw == null) return null;
    if (raw is num) return raw.toDouble();
    if (raw is String) return double.tryParse(raw);
    return null;
  }

  static double? _parsePriceChangePercentage24h(Map<String, dynamic> item) {
    final data = item['data'] as Map<String, dynamic>?;
    final pct = data?['price_change_percentage_24h'];
    if (pct is! Map) return null;
    final usd = pct['usd'];
    if (usd is num) return usd.toDouble();
    return null;
  }
}
