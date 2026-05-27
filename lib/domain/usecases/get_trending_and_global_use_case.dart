import '../../core/utils/result.dart';
import '../entities/global_market_overview.dart';
import '../entities/trending_coin.dart';
import '../repositories/crypto_repository.dart';

final class GetTrendingAndGlobalUseCase {
  GetTrendingAndGlobalUseCase(this._repository);

  final CryptoRepository _repository;

  Future<Result<(GlobalMarketOverview?, List<TrendingCoin>)>> call({
    bool forceRemote = false,
  }) => _repository.getTrendingAndGlobal(forceRemote: forceRemote);
}
