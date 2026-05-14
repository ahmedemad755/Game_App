import 'package:dartz/dartz.dart';
import 'package:game_app/core/errors/failures.dart';
import 'package:game_app/features/games/domain/repo/games_repository.dart';
import '../entities/game_entity.dart';

class GetPlaystationGamesUseCase {
  final GamesRepository repository;

  GetPlaystationGamesUseCase(this.repository);

  Future<Either<Failure, List<GameEntity>>> call() async {
    return await repository.getGamesByPlatform(18);
  }
}
