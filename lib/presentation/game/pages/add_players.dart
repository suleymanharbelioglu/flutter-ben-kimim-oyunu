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
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  List<PlayerEntity> players = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Players")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(child: _buildPlayerInputs()),
            _buildAddRemoveButtons(),
            const SizedBox(height: 16),
            _buildContinueButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🧍 Builds the player name input fields
  Widget _buildPlayerInputs() {
    return ListView.builder(
      itemCount: controllers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            controller: controllers[index],
            decoration: InputDecoration(
              labelText: "Player ${index + 1}",
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Name cannot be empty";
              }
              return null;
            },
          ),
        );
      },
    );
  }

  // ➕➖ Buttons to add or remove player input fields
  Widget _buildAddRemoveButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: _addPlayerField, child: const Text("+")),
        const SizedBox(width: 16),
        ElevatedButton(onPressed: _removePlayerField, child: const Text("-")),
      ],
    );
  }

  // ▶️ "Continue" button
  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: _createPlayers,
      child: const Text("Continue"),
    );
  }

  // ➕ Adds a new player input field
  void _addPlayerField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  // ➖ Removes the last player input field (min 2 fields)
  void _removePlayerField() {
    if (controllers.length > 2) {
      setState(() {
        controllers.removeLast();
      });
    }
  }

  // 🧠 Creates player entities and updates Cubits
  void _createPlayers() {
    if (_formKey.currentState!.validate()) {
      players = controllers
          .map((controller) => PlayerEntity(name: controller.text))
          .toList();

      debugPrint("Players: ${players.map((p) => p.name).join(', ')}");

      // Access cubits
      final allPlayersCubit = context.read<AllPlayersCubit>();
      final scoreCubit = context.read<PlayersListedByScoreCubit>();
      final currentPlayerCubit = context.read<CurrentPlayerCubit>();

      // Update cubits with new player list
      allPlayersCubit.addPlayers(players);
      scoreCubit.setPlayers(players);
      currentPlayerCubit.setPlayers(players);

      // Navigate to ScorePage
      AppNavigator.push(context, const ScorePage());
    }
  }
}
