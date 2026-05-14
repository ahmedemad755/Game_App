import '../../domain/entities/platform_entity.dart';

class PlatformModel extends PlatformEntity {
  const PlatformModel({
    required super.id,
    required super.name,
    required super.image,
    required super.gamesCount,
  });

  factory PlatformModel.fromJson(Map<String, dynamic> json) {
    return PlatformModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      image: json['image_background'] ?? '',
      gamesCount: json['games_count'] ?? 0,
    );
  }
}
