import '../../core/constants/api_constants.dart';
import '../../core/utils/result.dart';
import '../entities/coin_summary.dart';
import '../repositories/crypto_repository.dart';

final class GetMarketsPageUseCase {
  GetMarketsPageUseCase(this._repository);

  final CryptoRepository _repository;

  Future<Result<List<CoinSummary>>> call({
    required int page,
    int perPage = ApiConstants.defaultPerPage,
    String searchQuery = '',
    bool forceRemote = false,
  }) =>
      _repository.getMarketsPage(
        page: page,
        perPage: perPage,
        searchQuery: searchQuery,
        forceRemote: forceRemote,
      );
}
