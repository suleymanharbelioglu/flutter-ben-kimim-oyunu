import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/presentation/game/pages/add_players.dart';
import 'package:ben_kimim/presentation/how_to_play/pages/how_to_play.dart';
import 'package:ben_kimim/presentation/settings/pages/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Sade ve ferah arka plan
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ben Kimim?",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // Mor ton
                ),
              ),
              const SizedBox(height: 50),
              _homeButton(context, "Oyuna Başla", AppColors.primary, () {
                AppNavigator.push(context, const AddPlayersPage());
              }),
              const SizedBox(height: 20),
              _homeButton(context, "Nasıl Oynanır?", AppColors.primary, () {
                AppNavigator.push(context, const HowToPlayPage());
              }),
              const SizedBox(height: 20),
              _homeButton(context, "Ayarlar", AppColors.primary, () {
                AppNavigator.push(context, const SettingsPage());
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 220,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Buton yazısı her zaman beyaz
          ),
        ),
      ),
    );
  }
}
