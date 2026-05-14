import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/core/di/dependency_injection.dart';
import 'package:game_app/features/games/presentation/logic/cubit/details_cubit/game_details_cubit.dart';
import 'package:game_app/features/games/presentation/logic/cubit/games_cubit/games_cubit.dart';
import 'package:game_app/features/games/presentation/logic/cubit/platforms_cubit/platforms_cubit.dart';
import 'package:game_app/features/games/presentation/pages/game_details_screen.dart';
import 'package:game_app/features/games/presentation/pages/games_screen.dart';
import 'package:game_app/features/games/presentation/pages/platforms_screen.dart';

class Routes {
  static const String homeScreen = '/';
  static const String gamesScreen = '/games';
  static const String gameDetailsScreen = '/gameDetails';
}

class GamesRouteArguments {
  final int platformId;
  final String platformName;

  const GamesRouteArguments({
    required this.platformId,
    required this.platformName,
  });
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<PlatformsCubit>()..fetchPlatforms(),
            child: const PlatformsScreen(),
          ),
        );
      case Routes.gamesScreen:
        final args = settings.arguments as GamesRouteArguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<GamesCubit>()..fetchGamesByPlatform(args.platformId),
            child: GamesScreen(
              platformId: args.platformId,
              platformName: args.platformName,
            ),
          ),
        );
      case Routes.gameDetailsScreen:
        final gameId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<GameDetailsCubit>(),
            child: GameDetailsScreen(gameId: gameId),
          ),
        );
      default:
        return null;
    }
  }
}
