import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routing/routes.dart';
import '../../domain/entities/platform_entity.dart';
import '../logic/cubit/platforms_cubit/platforms_cubit.dart';
import '../logic/cubit/platforms_cubit/platforms_state.dart';

class PlatformsScreen extends StatelessWidget {
  const PlatformsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platforms'),
      ),
      body: BlocBuilder<PlatformsCubit, PlatformsState>(
        builder: (context, state) {
          if (state is PlatformsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlatformsSuccess) {
            return RefreshIndicator(
              onRefresh: () => context.read<PlatformsCubit>().fetchPlatforms(),
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.platforms.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 320,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return PlatformCard(platform: state.platforms[index]);
                },
              ),
            );
          } else if (state is PlatformsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          return const Center(
            child: Text(
              'Pull to load platforms',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

class PlatformCard extends StatelessWidget {
  final PlatformEntity platform;

  const PlatformCard({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.gamesScreen,
          arguments: GamesRouteArguments(
            platformId: platform.id,
            platformName: platform.name,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              platform.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF2A2A2A),
                child: const Icon(
                  Icons.videogame_asset,
                  color: Colors.white54,
                  size: 42,
                ),
              ),
            ),
            Container(color: Colors.black.withValues(alpha: 0.48)),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 28),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Text(
                            platform.name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.05,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'View games',
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Text(
                '${platform.gamesCount} games',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
