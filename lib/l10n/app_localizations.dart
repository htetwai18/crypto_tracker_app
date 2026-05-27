import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Crypto Tracker'**
  String get appTitle;

  /// No description provided for @marketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get marketsTitle;

  /// No description provided for @liveSourceLabel.
  ///
  /// In en, this message translates to:
  /// **'LIVE · COINGECKO'**
  String get liveSourceLabel;

  /// No description provided for @top20MarketCapLabel.
  ///
  /// In en, this message translates to:
  /// **'TOP 20 · 24H'**
  String get top20MarketCapLabel;

  /// No description provided for @volume24hLabel.
  ///
  /// In en, this message translates to:
  /// **'VOL 24H'**
  String get volume24hLabel;

  /// No description provided for @trendingSectionLabel.
  ///
  /// In en, this message translates to:
  /// **'TRENDING · 24H'**
  String get trendingSectionLabel;

  /// No description provided for @trendingCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} COINS ›'**
  String trendingCountLabel(int count);

  /// No description provided for @assetColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'ASSET'**
  String get assetColumnLabel;

  /// No description provided for @priceColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'PRICE · 24H'**
  String get priceColumnLabel;

  /// No description provided for @globalMarketCap.
  ///
  /// In en, this message translates to:
  /// **'Global market cap'**
  String get globalMarketCap;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search coins'**
  String get searchHint;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// No description provided for @noCoins.
  ///
  /// In en, this message translates to:
  /// **'No coins to show'**
  String get noCoins;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorOccurred;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @offlineCached.
  ///
  /// In en, this message translates to:
  /// **'Offline — showing cached data'**
  String get offlineCached;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @unfavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove favorite'**
  String get unfavorite;

  /// No description provided for @marketCapRank.
  ///
  /// In en, this message translates to:
  /// **'Rank {rank}'**
  String marketCapRank(int rank);

  /// No description provided for @detailTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailTitle;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switchLanguage;

  /// No description provided for @appOptions.
  ///
  /// In en, this message translates to:
  /// **'App options'**
  String get appOptions;

  /// No description provided for @menuLanguage.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get menuLanguage;

  /// No description provided for @menuTheme.
  ///
  /// In en, this message translates to:
  /// **'THEME'**
  String get menuTheme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @languageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageDialogTitle;

  /// No description provided for @themeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeDialogTitle;

  /// No description provided for @detailRankTitle.
  ///
  /// In en, this message translates to:
  /// **'{symbol} · RANK #{rank}'**
  String detailRankTitle(String symbol, int rank);

  /// No description provided for @marketStats.
  ///
  /// In en, this message translates to:
  /// **'MARKET STATS'**
  String get marketStats;

  /// No description provided for @aboutCoin.
  ///
  /// In en, this message translates to:
  /// **'ABOUT {name}'**
  String aboutCoin(String name);

  /// No description provided for @statMarketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get statMarketCap;

  /// No description provided for @statVolume24h.
  ///
  /// In en, this message translates to:
  /// **'Volume 24h'**
  String get statVolume24h;

  /// No description provided for @statAllTimeHigh.
  ///
  /// In en, this message translates to:
  /// **'All-Time High'**
  String get statAllTimeHigh;

  /// No description provided for @statAllTimeLow.
  ///
  /// In en, this message translates to:
  /// **'All-Time Low'**
  String get statAllTimeLow;

  /// No description provided for @statCirculatingSupply.
  ///
  /// In en, this message translates to:
  /// **'Circulating Supply'**
  String get statCirculatingSupply;

  /// No description provided for @statMaxSupply.
  ///
  /// In en, this message translates to:
  /// **'Max Supply'**
  String get statMaxSupply;

  /// No description provided for @change24hSuffix.
  ///
  /// In en, this message translates to:
  /// **'24h'**
  String get change24hSuffix;

  /// No description provided for @uncappedSupply.
  ///
  /// In en, this message translates to:
  /// **'∞ uncapped'**
  String get uncappedSupply;

  /// No description provided for @sourceLabel.
  ///
  /// In en, this message translates to:
  /// **'SOURCE'**
  String get sourceLabel;

  /// No description provided for @sampleDataLabel.
  ///
  /// In en, this message translates to:
  /// **'SAMPLE DATA'**
  String get sampleDataLabel;

  /// No description provided for @detailNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available for this coin.'**
  String get detailNoDescription;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'my': return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
