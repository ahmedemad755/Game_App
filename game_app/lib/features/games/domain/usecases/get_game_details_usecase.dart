import 'package:dartz/dartz.dart';
import 'package:game_app/features/games/domain/repo/games_repository.dart';
import '../../../../core/errors/failures.dart';
import '../entities/game_details_entity.dart';

class GetGameDetailsUseCase {
  final GamesRepository repository;

  GetGameDetailsUseCase(this.repository);

  /// دالة الـ call تسمح لنا باستدعاء الـ UseCase كأنه دالة: getGameDetailsUseCase(id)
  Future<Either<Failure, GameDetailsEntity>> call(int id) async {
    return await repository.getGameDetails(id);
  }
}