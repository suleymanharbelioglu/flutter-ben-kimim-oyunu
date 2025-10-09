import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/round_cubit.dart';
import 'package:ben_kimim/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEndPage extends StatelessWidget {
  const GameEndPage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    // Tur ve oyuncuları resetle
    context.read<RoundCubit>().resetRound();
    context.read<AllPlayersCubit>().clearPlayers();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
    return false; // varsayılan geri davranışını engelle
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Oyun Bitti"),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const SizedBox(height: 16),

            // Puan tablosu
            Expanded(
              child: BlocBuilder<PlayersListedByScoreCubit, List<dynamic>>(
                builder: (context, players) {
                  if (players.isEmpty)
                    return const Center(child: Text("Oyuncu yok"));
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final player = players[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                        color: Colors.white,
                        shadowColor: Colors.black26,
                        child: ListTile(
                          title: Text(
                            player.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Text(
                            "Puan: ${player.score}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(thickness: 2),

            // Kazanan
            BlocBuilder<PlayersListedByScoreCubit, List<dynamic>>(
              builder: (context, players) {
                if (players.isEmpty) return const SizedBox();
                final winner = players.first; // Listenin başı en yüksek puanlı
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.black38,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 32,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "🎉 Kazanan 🎉",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            winner.name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Ana Sayfa Butonu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Tur ve oyuncuları resetle
                    context.read<RoundCubit>().resetRound();
                    context.read<AllPlayersCubit>().clearPlayers();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Ana Sayfa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
