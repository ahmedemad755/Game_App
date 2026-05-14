import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_platforms_usecase.dart';
import 'platforms_state.dart';

class PlatformsCubit extends Cubit<PlatformsState> {
  final GetPlatformsUseCase getPlatformsUseCase;

  PlatformsCubit(this.getPlatformsUseCase) : super(PlatformsInitial());

  Future<void> fetchPlatforms() async {
    emit(PlatformsLoading());

    final result = await getPlatformsUseCase();

    result.fold(
      (failure) => emit(PlatformsError(failure.message)),
      (platforms) => emit(PlatformsSuccess(platforms)),
    );
  }
}
