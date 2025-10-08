import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/max_round_cubit.dart';
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
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<RoundCubit, int>(
              builder: (context, round) {
                final maxRound = context.watch<MaxRoundCubit>().state;
                return Text(
                  "Tur: $round / $maxRound",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
          ),
          Expanded(child: _buildScoreList()),
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildCurrentPlayerCard(context),
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
              elevation: 6,
              color: Colors.white,
              shadowColor: AppColors.secondary.withOpacity(0.3),
              child: ListTile(
                // Başındaki sıra numarasını kaldırdık
                title: Text(
                  player.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "Puan: ${player.score}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCurrentPlayerCard(BuildContext context) {
    return BlocBuilder<CurrentPlayerCubit, int>(
      builder: (context, currentIndex) {
        final allPlayers = context.read<AllPlayersCubit>().state;
        final currentPlayer = allPlayers[currentIndex];

        return Card(
          color: Colors.white,
          elevation: 6,
          shadowColor: AppColors.secondary.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Text(
                  "Sıradaki Oyuncu",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  currentPlayer.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToGamePage(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Oyna",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
