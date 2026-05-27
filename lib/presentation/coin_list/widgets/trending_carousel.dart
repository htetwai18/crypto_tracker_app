import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/domain/entities/trending_coin.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';
import 'package:crypto_tracker_app/presentation/common/navigation/coin_navigation.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/change_badge.dart';
import 'package:flutter/material.dart';

class TrendingCarousel extends StatelessWidget {
  const TrendingCarousel({
    super.key,
    required this.trending,
    required this.coins,
  });

  final List<TrendingCoin> trending;
  final List<CoinSummary> coins;

  CoinSummary? _match(TrendingCoin item) {
    for (final coin in coins) {
      if (coin.id == item.id) return coin;
    }
    return null;
  }

  CoinSummary _summaryFor(TrendingCoin item) {
    final matched = _match(item);
    if (matched != null) return matched;

    return CoinSummary(
      id: item.id,
      symbol: item.symbol,
      name: item.name,
      imageUrl: item.thumbUrl,
      currentPriceUsd: 0,
      priceChangePercentage24h: item.priceChangePercentage24h,
      marketCapUsd: null,
      marketCapRank: item.marketCapRank,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (trending.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final sectionStyle = context.sectionLabel.copyWith(letterSpacing: 0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
          child: Row(
            children: [
              Text(
                l10n.trendingSectionLabel,
                style: sectionStyle,
              ),
              const Spacer(),
              Text(
                l10n.trendingCountLabel(trending.length),
                style: sectionStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 124,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: trending.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final item = trending[index];
              return _TrendingCard(
                item: item,
                matched: _match(item),
                summary: _summaryFor(item),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({
    required this.item,
    required this.matched,
    required this.summary,
  });

  final TrendingCoin item;
  final CoinSummary? matched;
  final CoinSummary summary;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final text = context.appTextStyles;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rank = item.marketCapRank ?? matched?.marketCapRank;
    final cardColor =
        isDark ? palette.cardBackground : const Color(0xFFF7F4EF);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openCoinDetail(context, summary),
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          width: 168,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: palette.border),
            boxShadow:
                isDark
                    ? null
                    : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.network(
                      item.thumbUrl,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (context, error, stackTrace) => Icon(
                            Icons.currency_bitcoin,
                            size: 32,
                            color: palette.subtleText,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.symbol,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  if (rank != null)
                    Text(
                      '#$rank',
                      style: text.labelSmall?.copyWith(
                        fontSize: 10,
                        color: palette.subtleText,
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      formatBtcPrice(item.priceBtc),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleSmall?.copyWith(fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 6),
                  ChangeBadge(
                    changePercent: item.priceChangePercentage24h,
                    compact: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
