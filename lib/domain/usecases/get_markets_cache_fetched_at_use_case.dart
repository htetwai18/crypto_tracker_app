import '../repositories/crypto_repository.dart';

final class GetMarketsCacheFetchedAtUseCase {
  GetMarketsCacheFetchedAtUseCase(this._repository);

  final CryptoRepository _repository;

  Future<DateTime?> call({
    required int page,
    String searchQuery = '',
  }) => _repository.getMarketsCacheFetchedAt(page: page, searchQuery: searchQuery);
}
