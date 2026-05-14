import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final String releasedDate;

  const GameEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.releasedDate,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, rating, releasedDate];
}