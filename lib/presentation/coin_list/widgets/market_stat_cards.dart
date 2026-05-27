import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/domain/entities/global_market_overview.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/change_badge.dart';
import 'package:flutter/material.dart';

class MarketStatCards extends StatelessWidget {
  const MarketStatCards({super.key, required this.global});

  final GlobalMarketOverview? global;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              label: l10n.top20MarketCapLabel,
              value: formatCompactUsd(global?.totalMarketCapUsd),
              trailing: ChangeBadge(
                changePercent: global?.marketCapChangePercentage24h,
                compact: true,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              label: l10n.volume24hLabel,
              value: formatCompactUsd(global?.totalVolumeUsd24h),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value, this.trailing});

  final String label;
  final String value;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.sectionLabel.copyWith(letterSpacing: 0.6)),
          const SizedBox(height: 10),
          Text(value, style: context.appTextStyles.headlineSmall),
          if (trailing != null) ...[const SizedBox(height: 8), trailing!],
        ],
      ),
    );
  }
}
