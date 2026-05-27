import 'package:crypto_tracker_app/core/theme/app_palette.dart';
import 'package:crypto_tracker_app/presentation/coin_list/bloc/coin_list_bloc.dart';
import 'package:crypto_tracker_app/presentation/coin_list/widgets/coin_market_row.dart';
import 'package:crypto_tracker_app/presentation/coin_list/widgets/market_stat_cards.dart';
import 'package:crypto_tracker_app/presentation/coin_list/widgets/markets_header.dart';
import 'package:crypto_tracker_app/presentation/coin_list/widgets/markets_search_field.dart';
import 'package:crypto_tracker_app/presentation/coin_list/widgets/trending_carousel.dart';
import 'package:crypto_tracker_app/presentation/common/navigation/coin_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_tracker_app/l10n/app_localizations.dart';

class CoinListPage extends StatefulWidget {
  const CoinListPage({super.key});

  @override
  State<CoinListPage> createState() => _CoinListPageState();
}

class _CoinListPageState extends State<CoinListPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final bloc = context.read<CoinListBloc>();
    final st = bloc.state;
    final pos = _scrollController.position;
    if (pos.pixels > pos.maxScrollExtent - 400) {
      if (st.canLoadMore) {
        bloc.add(const CoinListLoadMoreRequested());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CoinListBloc, CoinListState>(
          listenWhen:
              (previous, current) =>
                  previous.actionMessage != current.actionMessage &&
                  current.actionMessage != null,
          listener: (context, state) {
            final msg = state.actionMessage;
            if (msg != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            }
          },
          builder: (context, state) {
            if (state.isInitialLoading && !state.isSearching) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            String? cacheAgeLabel() {
              final fetchedAt = state.cachedMarketsFetchedAt;
              if (fetchedAt == null) return null;
              final delta = DateTime.now().difference(fetchedAt);
              if (delta.inMinutes < 1) return 'Updated just now';
              if (delta.inHours < 1) return 'Updated ${delta.inMinutes}m ago';
              if (delta.inDays < 1) return 'Updated ${delta.inHours}h ago';
              return 'Updated ${delta.inDays}d ago';
            }

            if (state.errorMessage != null &&
                state.coins.isEmpty &&
                state.global == null &&
                !state.isSearching) {
              return Column(
                children: [
                  const MarketsHeader(),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage!,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            if (!state.offlineBanner)
                              FilledButton(
                                onPressed:
                                    () => context.read<CoinListBloc>().add(
                                      const CoinListRefreshRequested(),
                                    ),
                                child: Text(l10n.retry),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            final scrollView = CustomScrollView(
              controller: _scrollController,
              slivers: [
                const SliverToBoxAdapter(child: MarketsHeader()),
                if (state.offlineBanner)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: palette.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: palette.border),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.cloud_off, size: 18, color: palette.subtleText),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                cacheAgeLabel() == null
                                    ? l10n.offlineCached
                                    : '${l10n.offlineCached} · ${cacheAgeLabel()}',
                                style: TextStyle(
                                  color: palette.subtleText,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                SliverToBoxAdapter(child: MarketStatCards(global: state.global)),
                SliverToBoxAdapter(
                  child: TrendingCarousel(
                    trending: state.trending,
                    coins: state.coins,
                  ),
                ),
                SliverToBoxAdapter(
                  child: MarketsSearchField(
                    controller: _searchController,
                    onChanged:
                        (q) => context.read<CoinListBloc>().add(
                          CoinListSearchQueryChanged(q),
                        ),
                  ),
                ),
                if (state.isSearching)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                if (!state.isSearching) ...[
                  if (state.errorMessage != null && state.coins.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: palette.negative),
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(child: MarketsTableHeader()),
                  if (state.emptySearch ||
                      (state.coins.isEmpty && state.searchQuery.isNotEmpty))
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          l10n.noCoins,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: palette.subtleText),
                        ),
                      ),
                    ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final c = state.coins[index];
                        final fav = state.favoriteIds.contains(c.id);
                        return CoinMarketRow(
                          coin: c,
                          isFavorite: fav,
                          onTap: () => openCoinDetail(context, c),
                          onFavoritePressed:
                              () => context.read<CoinListBloc>().add(
                                CoinListFavoritePressed(c.id),
                              ),
                        );
                      },
                      childCount: state.coins.length,
                    ),
                  ),
                ],
                if (state.isLoadingMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            );

            if (state.offlineBanner) {
              return scrollView;
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<CoinListBloc>().add(
                  const CoinListRefreshRequested(),
                );
                await context.read<CoinListBloc>().stream.firstWhere(
                  (s) => !s.isRefreshing,
                );
              },
              child: scrollView,
            );
          },
        ),
      ),
    );
  }
}
