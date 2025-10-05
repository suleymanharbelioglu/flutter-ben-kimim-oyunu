import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPlayer = context.watch<CurrentPlayerCubit>().currentPlayer;

    return Scaffold(
      appBar: AppBar(title: Text("${currentPlayer.name}'s Turn")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
                builder: (context, players) {
                  final score = players
                      .firstWhere((p) => p.name == currentPlayer.name)
                      .score;
                  return Text(
                    "${currentPlayer.name} Score: $score",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),

              // 🔤 Random Name
              BlocBuilder<DisplayRandomFamousCubit, FamousEntity?>(
                builder: (context, famous) {
                  if (famous == null) {
                    return const Text(
                      "Loading...",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }
                  return Text(
                    famous.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              // ✅ Correct button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  context.read<PlayersListedByScoreCubit>().increaseScore(
                    currentPlayer,
                    1,
                  );
                  // Yeni random isim çağır
                  context.read<DisplayRandomFamousCubit>().fetchRandom();
                },
                child: const Text("Correct", style: TextStyle(fontSize: 20)),
              ),

              const SizedBox(height: 20),

              // 🔁 Pass button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                ),
                onPressed: () {
                  // Sadece yeni random isim çağır
                  context.read<DisplayRandomFamousCubit>().fetchRandom();
                },
                child: const Text("Pass", style: TextStyle(fontSize: 20)),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  context.read<CurrentPlayerCubit>().nextPlayer();
                  AppNavigator.pushReplacement(context, const ScorePage());
                },
                child: const Text("Finish Turn"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
