import 'package:crypto_tracker_app/presentation/common/formatters/market_formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('market formatters', () {
    test('formatCoinPrice formats large and small usd values', () {
      expect(formatCoinPrice(null), '—');
      expect(formatCoinPrice(3000), '\$3,000.00');
      expect(formatCoinPrice(0.00001234), '\$0.00001234');
    });

    test('formatBtcPrice formats btc suffix', () {
      expect(formatBtcPrice(null), '—');
      expect(formatBtcPrice(0.000534), '0.000534 BTC');
    });

    test('formatPercentChange adds sign and percent suffix', () {
      expect(formatPercentChange(null), '—');
      expect(formatPercentChange(4.2), '+4.20%');
      expect(formatPercentChange(-1.5), '-1.50%');
    });
  });
}
