import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/domain/user/entity/player.dart';
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
      appBar: AppBar(
        title: const Text("Oyuncu Ekle"),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(child: _buildPlayerInputs()),
              const SizedBox(height: 12),
              _buildAddRemoveButtons(),
              const SizedBox(height: 20),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInputs() {
    return ListView.builder(
      itemCount: controllers.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextFormField(
              controller: controllers[index],
              decoration: InputDecoration(
                labelText: "Oyuncu ${index + 1}",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.person, color: AppColors.primary),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "İsim boş olamaz";
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddRemoveButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _addPlayerField,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: AppColors.primary,
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: _removePlayerField,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: AppColors.primary,
          ),
          child: const Icon(Icons.remove, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _createPlayers,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Devam Et",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _addPlayerField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void _removePlayerField() {
    if (controllers.length > 2) {
      setState(() {
        controllers.removeLast();
      });
    }
  }

  void _createPlayers() {
    if (_formKey.currentState!.validate()) {
      players = controllers
          .map((controller) => PlayerEntity(name: controller.text))
          .toList();

      final allPlayersCubit = context.read<AllPlayersCubit>();
      final scoreCubit = context.read<PlayersListedByScoreCubit>();
      final currentPlayerCubit = context.read<CurrentPlayerCubit>();

      allPlayersCubit.addPlayers(players);
      scoreCubit.setPlayers(players);
      currentPlayerCubit.setPlayers(players);

      AppNavigator.push(context, const ScorePage());
    }
  }
}
