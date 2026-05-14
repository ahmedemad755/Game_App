import 'package:dio/dio.dart';
import 'package:game_app/features/games/data/repo/games_repository_impl.dart';
import 'package:game_app/features/games/domain/repo/games_repository.dart';
import 'package:game_app/features/games/domain/usecases/get_game_details_usecase.dart';
import 'package:game_app/features/games/domain/usecases/get_games_by_platform_usecase.dart';
import 'package:game_app/features/games/domain/usecases/get_platforms_usecase.dart';
import 'package:game_app/features/games/domain/usecases/search_games_usecase.dart';
import 'package:game_app/features/games/presentation/logic/cubit/details_cubit/game_details_cubit.dart';
import 'package:game_app/features/games/presentation/logic/cubit/games_cubit/games_cubit.dart';
import 'package:game_app/features/games/presentation/logic/cubit/platforms_cubit/platforms_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/games/data/datasources/games_remote_data_source.dart';
import '../api/dio_factory.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<Dio>(() => DioFactory.getDio());

  getIt.registerLazySingleton<GamesRemoteDataSource>(
    () => GamesRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<GamesRepository>(
    () => GamesRepositoryImpl(remoteDataSource: getIt<GamesRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetPlatformsUseCase>(
    () => GetPlatformsUseCase(getIt<GamesRepository>()),
  );

  getIt.registerLazySingleton<GetGamesByPlatformUseCase>(
    () => GetGamesByPlatformUseCase(getIt<GamesRepository>()),
  );

  getIt.registerLazySingleton<GetGameDetailsUseCase>(
    () => GetGameDetailsUseCase(getIt<GamesRepository>()),
  );

  getIt.registerLazySingleton<SearchGamesUseCase>(
    () => SearchGamesUseCase(getIt<GamesRepository>()),
  );

  getIt.registerFactory<PlatformsCubit>(
    () => PlatformsCubit(getIt<GetPlatformsUseCase>()),
  );

  getIt.registerFactory<GamesCubit>(
    () => GamesCubit(
      getIt<GetGamesByPlatformUseCase>(),
      getIt<SearchGamesUseCase>(),
    ),
  );

  getIt.registerFactory<GameDetailsCubit>(
    () => GameDetailsCubit(getIt<GetGameDetailsUseCase>()),
  );
}
