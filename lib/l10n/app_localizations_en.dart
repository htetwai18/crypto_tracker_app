// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crypto Tracker';

  @override
  String get marketsTitle => 'Markets';

  @override
  String get liveSourceLabel => 'LIVE · COINGECKO';

  @override
  String get top20MarketCapLabel => 'TOP 20 · 24H';

  @override
  String get volume24hLabel => 'VOL 24H';

  @override
  String get trendingSectionLabel => 'TRENDING · 24H';

  @override
  String trendingCountLabel(int count) {
    return '$count COINS ›';
  }

  @override
  String get assetColumnLabel => 'ASSET';

  @override
  String get priceColumnLabel => 'PRICE · 24H';

  @override
  String get globalMarketCap => 'Global market cap';

  @override
  String get trending => 'Trending';

  @override
  String get coins => 'Coins';

  @override
  String get searchHint => 'Search coins';

  @override
  String get pullToRefresh => 'Pull to refresh';

  @override
  String get noCoins => 'No coins to show';

  @override
  String get errorOccurred => 'Something went wrong';

  @override
  String get retry => 'Retry';

  @override
  String get offlineCached => 'Offline — showing cached data';

  @override
  String get favorite => 'Favorite';

  @override
  String get unfavorite => 'Remove favorite';

  @override
  String marketCapRank(int rank) {
    return 'Rank $rank';
  }

  @override
  String get detailTitle => 'Details';

  @override
  String get switchLanguage => 'Switch language';

  @override
  String get appOptions => 'App options';

  @override
  String get menuLanguage => 'LANGUAGE';

  @override
  String get menuTheme => 'THEME';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get languageDialogTitle => 'Language';

  @override
  String get themeDialogTitle => 'Theme';

  @override
  String detailRankTitle(String symbol, int rank) {
    return '$symbol · RANK #$rank';
  }

  @override
  String get marketStats => 'MARKET STATS';

  @override
  String aboutCoin(String name) {
    return 'ABOUT $name';
  }

  @override
  String get statMarketCap => 'Market Cap';

  @override
  String get statVolume24h => 'Volume 24h';

  @override
  String get statAllTimeHigh => 'All-Time High';

  @override
  String get statAllTimeLow => 'All-Time Low';

  @override
  String get statCirculatingSupply => 'Circulating Supply';

  @override
  String get statMaxSupply => 'Max Supply';

  @override
  String get change24hSuffix => '24h';

  @override
  String get uncappedSupply => '∞ uncapped';

  @override
  String get sourceLabel => 'SOURCE';

  @override
  String get sampleDataLabel => 'SAMPLE DATA';

  @override
  String get detailNoDescription => 'No description available for this coin.';
}
