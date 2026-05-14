import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_entity.dart';
import '../repo/games_repository.dart';

class GetGamesByPlatformUseCase {
  final GamesRepository repository;

  GetGamesByPlatformUseCase(this.repository);

  Future<Either<Failure, List<GameEntity>>> call(int platformId) async {
    return await repository.getGamesByPlatform(platformId);
  }
}
