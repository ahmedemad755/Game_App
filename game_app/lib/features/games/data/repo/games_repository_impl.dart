import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:game_app/features/games/domain/entities/game_details_entity.dart';
import 'package:game_app/features/games/domain/repo/games_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/game_entity.dart';
import '../../domain/entities/platform_entity.dart';
import '../datasources/games_remote_data_source.dart';

class GamesRepositoryImpl implements GamesRepository {
  final GamesRemoteDataSource remoteDataSource;

  GamesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PlatformEntity>>> getPlatforms() async {
    try {
      final remotePlatforms = await remoteDataSource.getPlatforms();
      return Right(remotePlatforms);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to load platforms"));
    } catch (e) {
      return const Left(ServerFailure("Unexpected error while loading platforms"));
    }
  }

  @override
  Future<Either<Failure, List<GameEntity>>> getGamesByPlatform(
    int platformId,
  ) async {
    try {
      final remoteGames = await remoteDataSource.getGamesByPlatform(platformId);
      return Right(remoteGames);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to load games"));
    } catch (e) {
      return const Left(ServerFailure("Unexpected error while loading games"));
    }
  }

  @override
  Future<Either<Failure, GameDetailsEntity>> getGameDetails(int id) async {
    try {
      final remoteGameDetails = await remoteDataSource.getGameDetails(id);
      return Right(remoteGameDetails);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to load game details"));
    } catch (e) {
      return const Left(ServerFailure("Unexpected error while loading details"));
    }
  }

  @override
  Future<Either<Failure, List<GameEntity>>> searchGames(
    String query, {
    int? platformId,
  }) async {
    try {
      final remoteGames = await remoteDataSource.searchGames(
        query,
        platformId: platformId,
      );
      return Right(remoteGames);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? "Failed to search games"));
    } catch (e) {
      return const Left(ServerFailure("Unexpected error while searching games"));
    }
  }
}
