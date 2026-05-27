import '../repositories/crypto_repository.dart';

/// Emits SQLite-backed favorite CoinGecko ids.
final class WatchFavoriteIdsUseCase {
  WatchFavoriteIdsUseCase(this._repository);

  final CryptoRepository _repository;

  Stream<Set<String>> call() => _repository.watchFavoriteIds();
}
