import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Puan Tablosu")),
      body: Column(
        children: [
          // Score table
          Expanded(
            child: BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
              builder: (context, players) {
                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return ListTile(
                      title: Text(player.name),
                      trailing: Text("Puan: ${player.score}"),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          // Current player & Play button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CurrentPlayerCubit, int>(
              builder: (context, currentIndex) {
                final allPlayers = context.read<AllPlayersCubit>().state;
                final currentPlayer = allPlayers[currentIndex];

                return Column(
                  children: [
                    Text(
                      "Sıradaki Oyuncu: ${currentPlayer.name}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to GamePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GamePage(),
                          ),
                        );
                      },
                      child: const Text("Oyna"),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
