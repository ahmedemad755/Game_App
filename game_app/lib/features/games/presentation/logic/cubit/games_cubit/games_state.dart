import 'package:equatable/equatable.dart';
import 'package:game_app/features/games/domain/entities/game_entity.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

class GamesInitial extends GamesState {}

class GamesLoading extends GamesState {}

class GamesSuccess extends GamesState {
  final List<GameEntity> games;
  const GamesSuccess(this.games);

  @override
  List<Object?> get props => [games];
}

class GamesError extends GamesState {
  final String message;
  const GamesError(this.message);

  @override
  List<Object?> get props => [message];
}