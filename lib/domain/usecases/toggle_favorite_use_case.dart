import '../../core/utils/result.dart';
import '../repositories/crypto_repository.dart';

final class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._repository);

  final CryptoRepository _repository;

  Future<Result<bool>> call({
    required String coinId,
    required bool asFavorite,
  }) =>
      _repository.setFavorite(
        coinId: coinId,
        favorite: asFavorite,
      );
}
