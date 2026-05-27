import 'package:crypto_tracker_app/core/theme/app_constant_text_style.dart';
import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/domain/entities/coin_detail.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/presentation/coin_detail/bloc/coin_detail_bloc.dart';
import 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/change_badge.dart';
import 'package:crypto_tracker_app/presentation/common/widgets/app_settings_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';

class CoinDetailPage extends StatelessWidget {
  const CoinDetailPage({super.key, required this.summary});

  final CoinSummary summary;

  static String _stripHtml(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    return raw.replaceAll(RegExp('<[^>]*>'), ' ').replaceAll(RegExp(r'\s+'), ' ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;

    return Scaffold(
      backgroundColor: palette.screenBackground,
      appBar: AppBar(
        backgroundColor: palette.screenBackground,
        title: BlocBuilder<CoinDetailBloc, CoinDetailState>(
          builder: (context, state) {
            final s = state.detail?.summary ?? summary;
            final rank = s.marketCapRank;
            final title =
                rank == null
                    ? s.symbol
                    : l10n.detailRankTitle(s.symbol, rank);
            return Text(
              title,
              style: context.appBarTitleStyle,
            );
          },
        ),
        actions: [
          const AppSettingsIcons(),
          BlocBuilder<CoinDetailBloc, CoinDetailState>(
            buildWhen: (p, c) => p.favoriteIds != c.favoriteIds,
            builder: (context, state) {
              final fav = state.favoriteIds.contains(summary.id);
              return IconButton(
                tooltip: fav ? l10n.unfavorite : l10n.favorite,
                icon: Icon(
                  fav ? Icons.star : Icons.star_border,
                  color: fav ? palette.positive : palette.subtleText,
                ),
                onPressed:
                    () => context.read<CoinDetailBloc>().add(
                      const CoinDetailFavoritePressed(),
                    ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<CoinDetailBloc, CoinDetailState>(
        listenWhen:
            (p, c) =>
                (p.failureMessage != c.failureMessage &&
                    c.failureMessage != null) ||
                (p.actionMessage != c.actionMessage && c.actionMessage != null),
        listener: (context, state) {
          final msg = state.actionMessage ?? state.failureMessage;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.detail == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final d = state.detail;
          final s = d?.summary ?? summary;
          final locale = Localizations.localeOf(context).languageCode;
          final descRaw = _stripHtml(d?.descriptionFor(locale));
          final desc = descRaw.length > 800 ? '${descRaw.substring(0, 800)}…' : descRaw;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CoinDetailBloc>().add(const CoinDetailRefreshed());
              await context.read<CoinDetailBloc>().stream.firstWhere(
                (st) => !st.isLoading,
              );
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                _CoinHeroSection(coin: s, l10n: l10n),
                const SizedBox(height: 28),
                _MarketStatsSection(detail: d, summary: s, l10n: l10n),
                if (desc.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  _AboutSection(name: s.name, description: desc, l10n: l10n),
                ],
                const SizedBox(height: 20),
                _FooterLinks(l10n: l10n),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CoinHeroSection extends StatelessWidget {
  const _CoinHeroSection({required this.coin, required this.l10n});

  final CoinSummary coin;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Column(
      children: [
        ClipOval(
          child: Image.network(
            coin.imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) =>
                    Icon(Icons.currency_bitcoin, size: 56, color: palette.subtleText),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          coin.name.toUpperCase(),
          style: context.coinHeroName,
        ),
        const SizedBox(height: 12),
        Text(
          formatCoinPrice(coin.currentPriceUsd),
          style: context.coinHeroPrice,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChangeBadge(changePercent: coin.priceChangePercentage24h),
            const SizedBox(width: 6),
            Text(
              '· ${l10n.change24hSuffix}',
              style: context.appTextStyles.labelMedium?.copyWith(
                color: palette.subtleText,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MarketStatsSection extends StatelessWidget {
  const _MarketStatsSection({
    required this.detail,
    required this.summary,
    required this.l10n,
  });

  final CoinDetail? detail;
  final CoinSummary summary;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final maxSupply =
        detail?.maxSupply == null
            ? l10n.uncappedSupply
            : formatSupplyAmount(detail?.maxSupply, summary.symbol);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.marketStats,
          style: context.sectionLabel,
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.45,
          children: [
            _StatCard(
              label: l10n.statMarketCap,
              value: formatCompactUsd(summary.marketCapUsd),
            ),
            _StatCard(
              label: l10n.statVolume24h,
              value: formatCompactUsd(detail?.volumeUsd24h),
            ),
            _StatCard(
              label: l10n.statAllTimeHigh,
              value: formatCoinPrice(detail?.athUsd),
              changePercent: detail?.athChangePercentage,
            ),
            _StatCard(
              label: l10n.statAllTimeLow,
              value: formatCoinPrice(detail?.atlUsd),
              changePercent: detail?.atlChangePercentage,
            ),
            _StatCard(
              label: l10n.statCirculatingSupply,
              value: formatSupplyAmount(detail?.circulatingSupply, summary.symbol),
            ),
            _StatCard(
              label: l10n.statMaxSupply,
              value: maxSupply,
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    this.changePercent,
  });

  final String label;
  final String value;
  final double? changePercent;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.statCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.statCardLabel,
          ),
          const Spacer(),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.statCardValue,
          ),
          if (changePercent != null) ...[
            const SizedBox(height: 6),
            Text(
              formatPercentChange(changePercent),
              style: AppConstantTextStyle.changeBadge(
                color:
                    changePercent! >= 0 ? palette.positive : palette.negative,
                compact: true,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({
    required this.name,
    required this.description,
    required this.l10n,
  });

  final String name;
  final String description;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutCoin(name.toUpperCase()),
          style: context.sectionLabel,
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: context.appTextStyles.bodyMedium,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _FooterLinks extends StatelessWidget {
  const _FooterLinks({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(l10n.sourceLabel, style: context.footerLink),
        const SizedBox(width: 24),
        Text(l10n.sampleDataLabel, style: context.footerLink),
      ],
    );
  }
}
