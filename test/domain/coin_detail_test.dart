import 'package:crypto_tracker_app/domain/entities/coin_detail.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:flutter_test/flutter_test.dart';

CoinDetail _detail(Map<String, String> descriptions) => CoinDetail(
  summary: const CoinSummary(
    id: 'eth',
    symbol: 'ETH',
    name: 'Ethereum',
    imageUrl: '',
    currentPriceUsd: 3000,
    priceChangePercentage24h: null,
    marketCapUsd: null,
    marketCapRank: 2,
  ),
  descriptions: descriptions,
);

void main() {
  group('CoinDetail.descriptionFor', () {
    test('returns localized description when available', () {
      final detail = _detail({'en': 'English text', 'my': 'Myanmar text'});

      expect(detail.descriptionFor('my'), 'Myanmar text');
    });

    test('falls back to english when locale is missing', () {
      final detail = _detail({'en': 'English text'});

      expect(detail.descriptionFor('my'), 'English text');
    });

    test('returns null when no descriptions exist', () {
      expect(_detail({}).descriptionFor('en'), isNull);
    });
  });
}
