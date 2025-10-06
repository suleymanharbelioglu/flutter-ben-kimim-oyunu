import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final int remainingSeconds;

  const GameTimer({super.key, required this.remainingSeconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$remainingSeconds',
      style: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}
