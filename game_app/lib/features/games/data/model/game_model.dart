import '../../domain/entities/game_entity.dart';

class GameModel extends GameEntity {
  const GameModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.rating,
    required super.releasedDate,
  });

  // تحويل الـ JSON لكائن GameModel
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      title: json['name'],
      imageUrl: json['background_image'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      releasedDate: json['released'] ?? 'Unknown',
    );
  }
}