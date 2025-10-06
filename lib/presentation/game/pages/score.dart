import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/game.dart';
import 'package:ben_kimim/presentation/game/pages/phone_to_forehead.dart';
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
          Expanded(child: _buildScoreList()),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildCurrentPlayerSection(context),
          ),
        ],
      ),
    );
  }

  /// Builds the score list for all players
  Widget _buildScoreList() {
    return BlocBuilder<PlayersListedByScoreCubit, List<PlayerEntity>>(
      builder: (context, players) {
        return ListView.builder(
          itemCount: players.length,
          itemBuilder: (context, index) {
            final player = players[index];
            return _buildPlayerTile(player);
          },
        );
      },
    );
  }

  /// Builds each player's tile (name and score)
  Widget _buildPlayerTile(PlayerEntity player) {
    return ListTile(
      title: Text(player.name),
      trailing: Text("Puan: ${player.score}"),
    );
  }

  /// Builds the section showing the current player and the "Play" button
  Widget _buildCurrentPlayerSection(BuildContext context) {
    return BlocBuilder<CurrentPlayerCubit, int>(
      builder: (context, currentIndex) {
        final allPlayers = context.read<AllPlayersCubit>().state;
        final currentPlayer = allPlayers[currentIndex];

        return Column(
          children: [
            Text(
              "Sıradaki Oyuncu: ${currentPlayer.name}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPlayButton(context),
          ],
        );
      },
    );
  }

  /// Builds the "Play" button and navigates to the game page
  Widget _buildPlayButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _navigateToGamePage(context),
      child: const Text("Oyna"),
    );
  }

  /// Handles navigation to the game page
  void _navigateToGamePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PhoneToForeheadPage()),
    );
  }
}
