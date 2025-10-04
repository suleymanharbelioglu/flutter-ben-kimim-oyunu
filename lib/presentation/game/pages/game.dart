import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current player from cubit
    final currentPlayer = context.watch<CurrentPlayerCubit>().currentPlayer;

    return Scaffold(
      appBar: AppBar(title: Text("${currentPlayer.name}'s Turn")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show current player score from PlayersListedByScoreCubit
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
              const SizedBox(height: 24),
              // Button to increase score
              ElevatedButton(
                onPressed: () {
                  // Increase current player's score by 1
                  context.read<PlayersListedByScoreCubit>().increaseScore(
                    currentPlayer,
                    1,
                  );
                },
                child: const Text("Increase Score"),
              ),
              const SizedBox(height: 24),
              // Finish turn/game button
              ElevatedButton(
                onPressed: () {
                  // Move to next player
                  context.read<CurrentPlayerCubit>().nextPlayer();

                  // Navigate back to ScorePage
                  AppNavigator.pushReplacement(context, ScorePage());
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
