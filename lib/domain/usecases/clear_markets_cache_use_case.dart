import '../repositories/crypto_repository.dart';

final class ClearMarketsCacheUseCase {
  ClearMarketsCacheUseCase(this._repository);

  final CryptoRepository _repository;

  Future<void> call() => _repository.clearMarketsCache();
}
