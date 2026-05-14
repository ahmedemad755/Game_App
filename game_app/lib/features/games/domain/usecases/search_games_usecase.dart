import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_entity.dart';
import '../repo/games_repository.dart';

class SearchGamesUseCase {
  final GamesRepository repository;

  SearchGamesUseCase(this.repository);

  Future<Either<Failure, List<GameEntity>>> call(
    String query, {
    int? platformId,
  }) async {
    return await repository.searchGames(query, platformId: platformId);
  }
}
