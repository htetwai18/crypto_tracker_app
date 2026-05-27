import 'package:crypto_tracker_app/core/utils/result.dart';
import 'package:crypto_tracker_app/domain/entities/coin_summary.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_page_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fakes/stub_crypto_repository.dart';

void main() {
  late StubCryptoRepository repo;
  late GetMarketsPageUseCase useCase;

  setUp(() {
    repo = StubCryptoRepository();
    useCase = GetMarketsPageUseCase(repo);
  });

  test('returns summaries from repository Ok result', () async {
    repo.marketsAnswer =
        ({
          required int page,
          int perPage = 20,
          String searchQuery = '',
          bool forceRemote = false,
        }) async {
          expect(page, 1);
          final sample = CoinSummary(
            id: 'bitcoin',
            symbol: 'BTC',
            name: 'Bitcoin',
            imageUrl: '',
            currentPriceUsd: 1,
            priceChangePercentage24h: 0,
            marketCapUsd: 1,
            marketCapRank: 1,
          );
          return Ok([sample]);
        };

    final Result<List<CoinSummary>> outcome = await useCase(page: 1);
    expect(outcome.isOk, isTrue);
    final coins = switch (outcome) {
      Ok(:final value) => value,
      Err() => throw StateError('expected Ok'),
    };
    expect(coins.single.id, 'bitcoin');
  });
}
