import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  final int remainingSeconds;

  const GameTimer({super.key, required this.remainingSeconds});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$remainingSeconds',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 48, // daha dengeli boyut
        fontWeight: FontWeight.bold,
        color: Colors.redAccent, // canlı kırmızı
        letterSpacing: 1.2,
        shadows: [
          Shadow(
            offset: Offset(1.5, 1.5),
            blurRadius: 3,
            color: Colors.black26, // hafif gölge
          ),
        ],
      ),
    );
  }
}
