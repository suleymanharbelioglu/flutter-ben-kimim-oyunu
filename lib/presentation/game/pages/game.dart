import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    // 📱 Force landscape orientation only for this page
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    // 🔙 Restore portrait orientation when leaving the page
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayer = context.watch<CurrentPlayerCubit>().currentPlayer;

    return Scaffold(
      // appBar: AppBar(title: Text("${currentPlayer.name}'s Turn")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildScore(context, currentPlayer),
            const SizedBox(height: 40),
            _buildRandomName(),
            const SizedBox(height: 40),
            _buildActionButtons(context, currentPlayer),
            const SizedBox(height: 40),
            _buildFinishTurnButton(context),
          ],
        ),
      ),
    );
  }

  // 🎯 Displays the current player's score
  Widget _buildScore(BuildContext context, PlayerEntity currentPlayer) {
    return BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
      builder: (context, players) {
        final score = players
            .firstWhere((p) => p.name == currentPlayer.name)
            .score;
        return Text(
          "${currentPlayer.name} Score: $score",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  // 🔤 Displays the current random famous name
  Widget _buildRandomName() {
    return BlocBuilder<DisplayRandomFamousCubit, FamousEntity?>(
      builder: (context, famous) {
        if (famous == null) {
          return const Text(
            "Loading...",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          );
        }
        return Text(
          famous.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        );
      },
    );
  }

  // ✅ and 🔁 Action buttons (Correct / Pass)
  Widget _buildActionButtons(BuildContext context, PlayerEntity currentPlayer) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(200, 50),
          ),
          onPressed: () {
            // Increase player score by 1 and fetch a new random name
            context.read<PlayersListedByScoreCubit>().increaseScore(
              currentPlayer,
              1,
            );
            context.read<DisplayRandomFamousCubit>().fetchRandom();
          },
          child: const Text("Correct", style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(200, 50),
          ),
          onPressed: () {
            // Just fetch a new random name
            context.read<DisplayRandomFamousCubit>().fetchRandom();
          },
          child: const Text("Pass", style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  // 🏁 Button to finish the current player's turn
  Widget _buildFinishTurnButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CurrentPlayerCubit>().nextPlayer();
        AppNavigator.pushReplacement(context, const ScorePage());
      },
      child: const Text("Finish Turn"),
    );
  }
}
