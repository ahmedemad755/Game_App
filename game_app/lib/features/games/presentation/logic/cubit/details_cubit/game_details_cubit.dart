import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/games/domain/usecases/get_game_details_usecase.dart';
import 'game_details_state.dart';

class GameDetailsCubit extends Cubit<GameDetailsState> {
  final GetGameDetailsUseCase getGameDetailsUseCase;

  GameDetailsCubit(this.getGameDetailsUseCase) : super(GameDetailsInitial());

  Future<void> getGameDetails(int id) async {
    emit(GameDetailsLoading());

    final result = await getGameDetailsUseCase(id);

    result.fold(
      (failure) => emit(GameDetailsError(failure.message)),
      (details) => emit(GameDetailsSuccess(details)),
    );
  }
}