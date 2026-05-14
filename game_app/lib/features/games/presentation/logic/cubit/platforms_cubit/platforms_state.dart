import 'package:equatable/equatable.dart';

import '../../../../domain/entities/platform_entity.dart';

abstract class PlatformsState extends Equatable {
  const PlatformsState();

  @override
  List<Object?> get props => [];
}

class PlatformsInitial extends PlatformsState {}

class PlatformsLoading extends PlatformsState {}

class PlatformsSuccess extends PlatformsState {
  final List<PlatformEntity> platforms;

  const PlatformsSuccess(this.platforms);

  @override
  List<Object?> get props => [platforms];
}

class PlatformsError extends PlatformsState {
  final String message;

  const PlatformsError(this.message);

  @override
  List<Object?> get props => [message];
}
