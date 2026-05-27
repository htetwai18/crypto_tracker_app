import 'dart:convert';

import '../../domain/entities/global_market_overview.dart';

final class GlobalMarketDto {
  GlobalMarketDto._(this.raw);

  final Map<String, dynamic> raw;

  factory GlobalMarketDto.fromJson(Map<String, dynamic> j) =>
      GlobalMarketDto._(j);

  static GlobalMarketDto? tryDecode(String payload) {
    try {
      final decoded = jsonDecode(payload) as Map<String, dynamic>;
      return GlobalMarketDto.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  GlobalMarketOverview? toEntityOrNull() {
    final data = raw['data'] as Map<String, dynamic>?;
    if (data == null) return null;
    final cap = data['total_market_cap'] as Map<String, dynamic>?;
    final vol = data['total_volume'] as Map<String, dynamic>?;
    final capUsd = (cap?['usd'] as num?)?.toDouble();
    final volUsd = (vol?['usd'] as num?)?.toDouble();
    final capChange =
        (data['market_cap_change_percentage_24h_usd'] as num?)?.toDouble();
    if (capUsd == null || volUsd == null) return null;
    return GlobalMarketOverview(
      totalMarketCapUsd: capUsd,
      totalVolumeUsd24h: volUsd,
      marketCapChangePercentage24h: capChange,
    );
  }
}
