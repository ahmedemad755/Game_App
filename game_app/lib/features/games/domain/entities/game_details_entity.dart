import 'package:equatable/equatable.dart';

class GameDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String description; // الوصف الكامل للعبة
  final String backgroundImage;
  final double rating;
  final String released;
  final List<String> developers; // قائمة المطورين

  const GameDetailsEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.backgroundImage,
    required this.rating,
    required this.released,
    required this.developers,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        backgroundImage,
        rating,
        released,
        developers,
      ];
}