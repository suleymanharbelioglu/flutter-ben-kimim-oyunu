import 'package:ben_kimim/domain/user/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Score extends StatelessWidget {
  final PlayerEntity currentPlayer; // ✅ currentPlayer parametre olarak eklendi

  const Score({super.key, required this.currentPlayer});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
      builder: (context, players) {
        final score = players
            .firstWhere((p) => p.name == currentPlayer.name)
            .score;
        return Text(
          " Score $score",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
