import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/details_cubit/game_details_cubit.dart';
import '../logic/cubit/details_cubit/game_details_state.dart';

class GameDetailsScreen extends StatefulWidget {
  final int gameId;
  const GameDetailsScreen({super.key, required this.gameId});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // استدعاء بيانات اللعبة فور الدخول للشاشة
    context.read<GameDetailsCubit>().getGameDetails(widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // لجعل الصورة خلف الـ AppBar
      body: BlocBuilder<GameDetailsCubit, GameDetailsState>(
        builder: (context, state) {
          if (state is GameDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // حالة التحميل
          } else if (state is GameDetailsSuccess) {
            final game = state.gameDetails;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عرض صورة اللعبة
                  Image.network(
                    game.backgroundImage,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          game.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            Text(
                              " ${game.rating} / 5",
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Spacer(),
                            Text("Released: ${game.released}"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Developers:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // عرض قائمة المطورين
                        Text(
                          game.developers.join(', '),
                          style: const TextStyle(color: Colors.blueAccent),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "About the Game:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // عرض الوصف الكامل للعبة
                        Text(
                          game.description,
                          style: const TextStyle(fontSize: 16, height: 1.6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GameDetailsError) {
            return Center(child: Text(state.message)); // حالة الخطأ
          }
          return const SizedBox();
        },
      ),
    );
  }
}
