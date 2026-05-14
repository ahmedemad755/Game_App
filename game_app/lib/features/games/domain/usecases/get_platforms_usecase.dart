import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/platform_entity.dart';
import '../repo/games_repository.dart';

class GetPlatformsUseCase {
  final GamesRepository repository;

  GetPlatformsUseCase(this.repository);

  Future<Either<Failure, List<PlatformEntity>>> call() async {
    return await repository.getPlatforms();
  }
}
