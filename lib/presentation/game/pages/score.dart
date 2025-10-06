import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/phone_to_forehead.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Puan Tablosu"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Expanded(child: _buildScoreList()),
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildCurrentPlayerSection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreList() {
    return BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
      builder: (context, players) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(player.name),
                trailing: Text(
                  "Puan: ${player.score}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCurrentPlayerSection(BuildContext context) {
    return BlocBuilder<CurrentPlayerCubit, int>(
      builder: (context, currentIndex) {
        final allPlayers = context.read<AllPlayersCubit>().state;
        final currentPlayer = allPlayers[currentIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Sıradaki Oyuncu: ${currentPlayer.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _navigateToGamePage(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Oyna",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToGamePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PhoneToForeheadPage()),
    );
  }
}
