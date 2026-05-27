import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/change_badge.dart';
import 'package:flutter/material.dart';

class MarketsTableHeader extends StatelessWidget {
  const MarketsTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final style = context.tableHeader;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          SizedBox(width: 28, child: Text('#', style: style)),
          const SizedBox(width: 12),
          Expanded(child: Text(l10n.assetColumnLabel, style: style)),
          Text(l10n.priceColumnLabel, style: style),
        ],
      ),
    );
  }
}

class CoinMarketRow extends StatelessWidget {
  const CoinMarketRow({
    super.key,
    required this.coin,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoritePressed,
  });

  final CoinSummary coin;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final text = context.appTextStyles;
    final rank = coin.marketCapRank;
    final subtitle = coin.marketCapUsd == null
        ? coin.symbol
        : '${coin.symbol} · ${formatCompactUsd(coin.marketCapUsd)}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  rank == null ? '—' : '$rank',
                  style: text.bodyMedium?.copyWith(
                    color: palette.subtleText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ClipOval(
                child: Image.network(
                  coin.imageUrl,
                  width: 36,
                  height: 36,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.currency_bitcoin, size: 36),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall,
                    ),
                  ],
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  size: 20,
                  color: isFavorite ? palette.positive : palette.subtleText,
                ),
                onPressed: onFavoritePressed,
              ),
              const SizedBox(width: 4),
              SizedBox(
                width: 92,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCoinPrice(coin.currentPriceUsd),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    ChangeBadge(changePercent: coin.priceChangePercentage24h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
