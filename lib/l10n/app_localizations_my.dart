// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'ကြေးငွေစောင့်ကြည့်ရန်';

  @override
  String get marketsTitle => 'ဈေးကွက်များ';

  @override
  String get liveSourceLabel => 'LIVE · COINGECKO';

  @override
  String get top20MarketCapLabel => 'ထိပ်တန်ဖိုး ၂၀ · ၂၄ နာရီ';

  @override
  String get volume24hLabel => '၂၄ နာရီ ရောင်းဝယ်မှု';

  @override
  String get trendingSectionLabel => 'အလန်းစား · ၂၄ နာရီ';

  @override
  String trendingCountLabel(int count) {
    return '$count ခု ›';
  }

  @override
  String get assetColumnLabel => 'ပိုင်ဆိုင်မှု';

  @override
  String get priceColumnLabel => 'ဈေး · ၂၄ နာရီ';

  @override
  String get globalMarketCap => 'ကမ္ဘာလုံးဆိုင်ရာ ထိပ်တန်ဖိုး';

  @override
  String get trending => 'အလန်းစား';

  @override
  String get coins => 'coins';

  @override
  String get searchHint => 'coins ရှာဖွေရန်';

  @override
  String get pullToRefresh => 'ထိုးဆွဲ၍ ပြန်လည်ဖတ်ရန်';

  @override
  String get noCoins => 'ပြသရန် ဒေတာ မရှိပါ';

  @override
  String get errorOccurred => 'အမှား ဖြစ်ပွားခဲ့သည်';

  @override
  String get retry => 'ထပ်ကြိုးစား';

  @override
  String get offlineCached => 'အင်တာနက် မရှိ — သိမ်းထားသည်ကို ပြသနေသည်';

  @override
  String get favorite => 'အကြိုက်သတ်မှတ်';

  @override
  String get unfavorite => 'ဖယ်ရှား';

  @override
  String marketCapRank(int rank) {
    return 'အဆင့် $rank';
  }

  @override
  String get detailTitle => 'အသေးစိတ်';

  @override
  String get switchLanguage => 'ဘာသာစကား ပြောင်းရန်';

  @override
  String get appOptions => 'ဆက်တင်များ';

  @override
  String get menuLanguage => 'ဘာသာစကား';

  @override
  String get menuTheme => 'အပြင်အဆင်';

  @override
  String get themeLight => 'အလင်း';

  @override
  String get themeDark => 'အမှောင်';

  @override
  String get themeSystem => 'စနစ်';

  @override
  String get languageDialogTitle => 'ဘာသာစကား';

  @override
  String get themeDialogTitle => 'အပြင်အဆင်';

  @override
  String detailRankTitle(String symbol, int rank) {
    return '$symbol · အဆင့် #$rank';
  }

  @override
  String get marketStats => 'ဈေးကွက် အချက်အလက်';

  @override
  String aboutCoin(String name) {
    return '$name အကြောင်း';
  }

  @override
  String get statMarketCap => 'ဈေးကွက် ထိပ်တန်ဖိုး';

  @override
  String get statVolume24h => '၂၄ နာရီ ရောင်းဝယ်မှု';

  @override
  String get statAllTimeHigh => 'သမိုင်းတွင်း အမြင့်ဆုံး';

  @override
  String get statAllTimeLow => 'သမိုင်းတွင်း အနိမ့်ဆုံး';

  @override
  String get statCirculatingSupply => 'လည်ပတ်နေသော ပမာဏ';

  @override
  String get statMaxSupply => 'အများဆုံး ပမာဏ';

  @override
  String get change24hSuffix => '၂၄ နာရီ';

  @override
  String get uncappedSupply => '∞ ကန့်သတ်ချက် မရှိ';

  @override
  String get sourceLabel => 'ရင်းမြစ်';

  @override
  String get sampleDataLabel => 'ဥပမာ ဒေတာ';

  @override
  String get detailNoDescription => 'ဤ coin အတွက် ဖော်ပြချက် မရှိပါ။';
}
