import 'package:dartz/dartz.dart';
import 'package:game_app/features/games/domain/entities/game_details_entity.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_entity.dart';
import '../entities/platform_entity.dart';

abstract class GamesRepository {
  Future<Either<Failure, List<PlatformEntity>>> getPlatforms();

  Future<Either<Failure, List<GameEntity>>> getGamesByPlatform(int platformId);

  Future<Either<Failure, GameDetailsEntity>> getGameDetails(int id);

  Future<Either<Failure, List<GameEntity>>> searchGames(
    String query, {
    int? platformId,
  });
}
