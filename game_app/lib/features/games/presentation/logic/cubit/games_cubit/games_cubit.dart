import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/games/domain/usecases/get_games_by_platform_usecase.dart';
import 'package:game_app/features/games/domain/usecases/search_games_usecase.dart';

import 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final GetGamesByPlatformUseCase getGamesByPlatformUseCase;
  final SearchGamesUseCase searchGamesUseCase;

  int? _currentPlatformId;

  GamesCubit(this.getGamesByPlatformUseCase, this.searchGamesUseCase)
    : super(GamesInitial());

  Future<void> fetchGamesByPlatform(int platformId) async {
    _currentPlatformId = platformId;
    emit(GamesLoading());

    final result = await getGamesByPlatformUseCase(platformId);

    result.fold(
      (failure) => emit(GamesError(failure.message)),
      (games) => emit(GamesSuccess(games)),
    );
  }

  Future<void> searchGames(String query) async {
    if (query.isEmpty) {
      final platformId = _currentPlatformId;
      if (platformId != null) {
        fetchGamesByPlatform(platformId);
      }
      return;
    }

    emit(GamesLoading());
    final result = await searchGamesUseCase(
      query,
      platformId: _currentPlatformId,
    );
    result.fold(
      (failure) => emit(GamesError(failure.message)),
      (games) => emit(GamesSuccess(games)),
    );
  }
}
