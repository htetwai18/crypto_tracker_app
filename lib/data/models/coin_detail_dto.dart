import 'dart:convert';

import '../../domain/entities/coin_detail.dart';
import 'coin_market_dto.dart';

/// Subset of `/coins/{id}` used on the detail page.
final class CoinDetailDto {
  CoinDetailDto._(this.raw);

  final Map<String, dynamic> raw;

  factory CoinDetailDto.fromJson(Map<String, dynamic> j) => CoinDetailDto._(j);

  static CoinDetailDto? tryDecode(String payload) {
    try {
      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      return CoinDetailDto.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  CoinDetail toEntity() {
    final id = raw['id'] as String? ?? '';
    final symbol = (raw['symbol'] as String? ?? '').toUpperCase();
    final name = raw['name'] as String? ?? '';
    final thumb = '${raw['image']?['small'] ?? raw['image']?['thumb'] ?? ''}';

    final marketData = raw['market_data'] as Map<String, dynamic>? ?? const {};
    final current = marketData['current_price'] as Map<String, dynamic>?;
    final priceUsd = (current?['usd'] as num?)?.toDouble() ?? 0;
    final change24 = (marketData['price_change_percentage_24h'] as num?)
        ?.toDouble();
    final mcapUsd = (marketData['market_cap']?['usd'] as num?)?.toDouble();
    final rank = (marketData['market_cap_rank'] as num?)?.toInt();
    final volumeUsd = (marketData['total_volume']?['usd'] as num?)?.toDouble();
    final athUsd = (marketData['ath']?['usd'] as num?)?.toDouble();
    final atlUsd = (marketData['atl']?['usd'] as num?)?.toDouble();
    final athChange = (marketData['ath_change_percentage']?['usd'] as num?)
        ?.toDouble();
    final atlChange = (marketData['atl_change_percentage']?['usd'] as num?)
        ?.toDouble();
    final circulating = (marketData['circulating_supply'] as num?)?.toDouble();
    final maxSupply = (marketData['max_supply'] as num?)?.toDouble();

    final descMap = raw['description'] as Map<String, dynamic>?;
    final descriptions = <String, String>{};
    if (descMap != null) {
      for (final entry in descMap.entries) {
        final value = entry.value;
        if (value is String && value.trim().isNotEmpty) {
          descriptions[entry.key] = value;
        }
      }
    }

    List<String> categoryList = const [];
    final cats = raw['categories'];
    if (cats is List) {
      categoryList = cats.whereType<String>().toList(growable: false);
    } else if (cats is Map<String, dynamic>) {
      final inner = cats['categories'] as List<dynamic>?;
      if (inner != null) {
        categoryList = inner
            .whereType<Map<String, dynamic>>()
            .map((c) => c['name'] as String? ?? '')
            .where((n) => n.isNotEmpty)
            .toList(growable: false);
      }
    }

    final hashing = raw['hashing_algorithm'] as String?;

    final summary = CoinMarketDto(
      id: id,
      symbol: symbol,
      name: name,
      image: thumb,
      currentPrice: priceUsd,
      priceChangePct24h: change24,
      marketCap: mcapUsd,
      marketCapRank: rank,
    ).toEntity();

    return CoinDetail(
      summary: summary,
      descriptions: descriptions,
      hashingAlgorithm: hashing,
      categories: categoryList,
      volumeUsd24h: volumeUsd,
      athUsd: athUsd,
      atlUsd: atlUsd,
      athChangePercentage: athChange,
      atlChangePercentage: atlChange,
      circulatingSupply: circulating,
      maxSupply: maxSupply,
    );
  }
}
