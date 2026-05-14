import 'package:equatable/equatable.dart';

class PlatformEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final int gamesCount;

  const PlatformEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.gamesCount,
  });

  @override
  List<Object?> get props => [id, name, image, gamesCount];
}
