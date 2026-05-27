import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_tracker_app/core/network/dio_client.dart';
import 'package:crypto_tracker_app/core/network/network_info.dart';
import 'package:crypto_tracker_app/data/datasources/local/coin_local_datasource.dart';
import 'package:crypto_tracker_app/data/datasources/local/drift/database.dart';
import 'package:crypto_tracker_app/data/datasources/remote/coin_remote_datasource.dart';
import 'package:crypto_tracker_app/data/repositories/crypto_repository_impl.dart';
import 'package:crypto_tracker_app/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_app/domain/usecases/clear_markets_cache_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_coin_detail_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_cache_fetched_at_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_markets_page_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/get_trending_and_global_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/toggle_favorite_use_case.dart';
import 'package:crypto_tracker_app/domain/usecases/watch_favorite_ids_use_case.dart';
import 'package:crypto_tracker_app/presentation/coin_list/bloc/coin_list_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  sl.registerLazySingleton<Connectivity>(Connectivity.new);
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton<Dio>(createDio);

  sl.registerLazySingleton<AppDatabase>(AppDatabase.new);

  sl.registerLazySingleton<CoinRemoteDataSource>(
    () => CoinRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CoinLocalDataSource>(
    () => CoinLocalDataSourceImpl(sl<AppDatabase>().appDao),
  );
  sl.registerLazySingleton<CryptoRepository>(
    () => CryptoRepositoryImpl(
      networkInfo: sl(),
      remote: sl(),
      local: sl(),
    ),
  );

  sl.registerFactory(() => WatchFavoriteIdsUseCase(sl()));
  sl.registerFactory(() => GetTrendingAndGlobalUseCase(sl()));
  sl.registerFactory(() => GetMarketsPageUseCase(sl()));
  sl.registerFactory(() => GetMarketsCacheFetchedAtUseCase(sl()));
  sl.registerFactory(() => GetCoinDetailUseCase(sl()));
  sl.registerFactory(() => ToggleFavoriteUseCase(sl()));
  sl.registerFactory(() => ClearMarketsCacheUseCase(sl()));

  sl.registerFactory(
    () => CoinListBloc(
      watchFavoriteIds: sl(),
      getTrendingAndGlobalUseCase: sl(),
      getMarketsPageUseCase: sl(),
      getMarketsCacheFetchedAtUseCase: sl(),
      toggleFavoriteUseCase: sl(),
      clearMarketsCacheUseCase: sl(),
      networkInfo: sl(),
    ),
  );
}
