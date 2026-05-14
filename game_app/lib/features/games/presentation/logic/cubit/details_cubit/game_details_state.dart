import 'package:equatable/equatable.dart';
import 'package:game_app/features/games/domain/entities/game_details_entity.dart';

abstract class GameDetailsState extends Equatable {
  const GameDetailsState();

  @override
  List<Object?> get props => [];
}

class GameDetailsInitial extends GameDetailsState {}

class GameDetailsLoading extends GameDetailsState {}

class GameDetailsSuccess extends GameDetailsState {
  final GameDetailsEntity gameDetails;
  const GameDetailsSuccess(this.gameDetails);

  @override
  List<Object?> get props => [gameDetails];
}

class GameDetailsError extends GameDetailsState {
  final String message;
  const GameDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}