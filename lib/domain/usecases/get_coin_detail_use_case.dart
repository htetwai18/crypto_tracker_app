import '../../core/utils/result.dart';
import '../entities/coin_detail.dart';
import '../repositories/crypto_repository.dart';

final class GetCoinDetailUseCase {
  GetCoinDetailUseCase(this._repository);

  final CryptoRepository _repository;

  Future<Result<CoinDetail>> call(String coinId, {bool forceRemote = false}) =>
      _repository.getCoinDetail(coinId, forceRemote: forceRemote);
}
