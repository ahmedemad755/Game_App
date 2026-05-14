
import 'package:game_app/features/games/domain/entities/game_details_entity.dart';

class GameDetailsModel extends GameDetailsEntity {
  const GameDetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.backgroundImage,
    required super.rating,
    required super.released,
    required super.developers,
  });

  factory GameDetailsModel.fromJson(Map<String, dynamic> json) {
    return GameDetailsModel(
      id: json['id'],
      title: json['name'],
      description: json['description_raw'] ?? json['description'] ?? '', // نفضل الوصف الخام بدون HTML
      backgroundImage: json['background_image'] ?? '',
      rating: (json['rating'] as num).toDouble(),
      released: json['released'] ?? 'Unknown',
      developers: (json['developers'] as List?)
              ?.map((dev) => dev['name'].toString())
              .toList() ?? [],
    );
  }
}