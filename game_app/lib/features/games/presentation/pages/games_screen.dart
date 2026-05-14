import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/games/presentation/logic/cubit/games_cubit/games_cubit.dart';
import 'package:game_app/features/games/presentation/logic/cubit/games_cubit/games_state.dart';

import '../widgets/game_item_widget.dart';

class GamesScreen extends StatelessWidget {
  final int platformId;
  final String platformName;

  const GamesScreen({
    super.key,
    required this.platformId,
    required this.platformName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search $platformName games...",
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          onChanged: (query) {
            context.read<GamesCubit>().searchGames(query);
          },
        ),
      ),
      body: BlocBuilder<GamesCubit, GamesState>(
        builder: (context, state) {
          if (state is GamesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GamesSuccess) {
            if (state.games.isEmpty) {
              return Center(child: Text("No games found for $platformName"));
            }
            return ListView.builder(
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                return GameItemWidget(game: state.games[index]);
              },
            );
          } else if (state is GamesError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("Choose a $platformName game"));
        },
      ),
    );
  }
}
