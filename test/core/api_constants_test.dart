import 'package:crypto_tracker_app/core/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApiConstants exposes CoinGecko base url and paths', () {
    expect(ApiConstants.baseUrl, 'https://api.coingecko.com/api/v3');
    expect(ApiConstants.marketsPath, '/coins/markets');
    expect(ApiConstants.globalPath, '/global');
    expect(ApiConstants.trendingSearchPath, '/search/trending');
    expect(ApiConstants.searchPath, '/search');
    expect(ApiConstants.coinDetailPath('bitcoin'), '/coins/bitcoin');
  });
}
