import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/presentation/game/pages/add_players.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [playGameButton(context)],
        ),
      ),
    );
  }

  playGameButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigator.push(context, AddPlayersPage());
      },
      child: Text("Oyna"),
    );
  }
}
