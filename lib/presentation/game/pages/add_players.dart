import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlayersPage extends StatefulWidget {
  const AddPlayersPage({super.key});

  @override
  State<AddPlayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  List<PlayerEntity> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Oyuncu Girişi")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: TextFormField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        labelText: "Oyuncu ${index + 1}",
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "İsim boş olamaz";
                        }
                        return null;
                      },
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      controllers.add(TextEditingController());
                    });
                  },
                  child: const Text("+"),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    if (controllers.length > 2) {
                      setState(() {
                        controllers.removeLast();
                      });
                    }
                  },
                  child: const Text("-"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createPlayers,
              child: const Text("Devam"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _createPlayers() {
    if (_formKey.currentState!.validate()) {
      players = controllers
          .map((controller) => PlayerEntity(name: controller.text))
          .toList();

      for (var p in players) {
        debugPrint('Oyuncu: ${p.name}');
      }

      final allPlayersCubit = context.read<AllPlayersCubit>();
      final scoreCubit = context.read<PlayersListedByScoreCubit>();
      final currentPlayerCubit = context.read<CurrentPlayerCubit>();

      // Add players to cubits
      allPlayersCubit.addPlayers(players);
      scoreCubit.setPlayers(players); // Score list cubitini güncelle
      currentPlayerCubit.setPlayers(
        players,
      ); // CurrentPlayerCubit'e oyuncuları set et

      // Navigate to ScorePage
      AppNavigator.push(context, ScorePage());
    }
  }
}
