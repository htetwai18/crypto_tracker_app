import 'package:crypto_tracker_app/data/models/trending_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TrendingResponseDto', () {
    test('maps slug id and market fields from trending payload', () {
      final dto = TrendingResponseDto.fromJson({
        'coins': [
          {
            'item': {
              'id': 'pepe',
              'coin_id': 24478,
              'symbol': 'pepe',
              'name': 'Pepe',
              'market_cap_rank': 46,
              'thumb': 'https://example.com/pepe.png',
              'price_btc': 0.00000000123,
              'data': {
                'price_btc': '0.00000000123',
                'price_change_percentage_24h': {'usd': 15.67},
              },
            },
          },
        ],
      });

      final coins = dto.toTrendingCoins();

      expect(coins, hasLength(1));
      expect(coins.first.id, 'pepe');
      expect(coins.first.symbol, 'PEPE');
      expect(coins.first.name, 'Pepe');
      expect(coins.first.marketCapRank, 46);
      expect(coins.first.priceBtc, closeTo(0.00000000123, 1e-15));
      expect(coins.first.priceChangePercentage24h, 15.67);
    });

    test('tryDecode returns null for invalid json', () {
      expect(TrendingResponseDto.tryDecode('not-json'), isNull);
    });
  });
}
