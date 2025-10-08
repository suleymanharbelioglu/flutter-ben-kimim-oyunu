import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameEndPage extends StatelessWidget {
  const GameEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      color: AppColors.secondary.withOpacity(0.1),
                      child: ListTile(
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
                  color: AppColors.primary.withOpacity(0.1),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Text(
                      "Kazanan: ${winner.name}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
