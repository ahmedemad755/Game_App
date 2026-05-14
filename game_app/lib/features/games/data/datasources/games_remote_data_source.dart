import 'package:dio/dio.dart';
import 'package:game_app/features/games/data/model/game_details_model.dart';
import 'package:game_app/features/games/data/model/game_model.dart';
import 'package:game_app/features/games/data/model/platform_model.dart';

import '../../../../core/api/api_constants.dart';

abstract class GamesRemoteDataSource {
  Future<List<PlatformModel>> getPlatforms();
  Future<List<GameModel>> getGamesByPlatform(int platformId);
  Future<List<GameModel>> searchGames(String query, {int? platformId});
  Future<GameDetailsModel> getGameDetails(int id);
}

class GamesRemoteDataSourceImpl implements GamesRemoteDataSource {
  final Dio dio;
  GamesRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PlatformModel>> getPlatforms() async {
    final response = await dio.get(ApiConstants.platformsEndpoint);
    final List data = response.data['results'];
    return data.map((json) => PlatformModel.fromJson(json)).toList();
  }

  @override
  Future<List<GameModel>> getGamesByPlatform(int platformId) async {
    final response = await dio.get(
      ApiConstants.gamesEndpoint,
      queryParameters: {
        'key': ApiConstants.apiKey,
        'platforms': platformId,
      },
    );
    final List data = response.data['results'];
    return data.map((json) => GameModel.fromJson(json)).toList();
  }

  @override
  Future<List<GameModel>> searchGames(String query, {int? platformId}) async {
    final response = await dio.get(
      ApiConstants.gamesEndpoint,
      queryParameters: {
        'key': ApiConstants.apiKey,
        'search': query,
        if (platformId != null) 'platforms': platformId,
      },
    );
    final List data = response.data['results'];
    return data.map((json) => GameModel.fromJson(json)).toList();
  }

  @override
  Future<GameDetailsModel> getGameDetails(int id) async {
    final response = await dio.get(
      "${ApiConstants.gamesEndpoint}/$id",
      queryParameters: {'key': ApiConstants.apiKey},
    );
    return GameDetailsModel.fromJson(response.data);
  }
}
