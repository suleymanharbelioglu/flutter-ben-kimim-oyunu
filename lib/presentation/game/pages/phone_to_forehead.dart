import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:ben_kimim/presentation/game/pages/game.dart';

class PhoneToForeheadPage extends StatefulWidget {
  const PhoneToForeheadPage({super.key});

  @override
  State<PhoneToForeheadPage> createState() => _PhoneToForeheadPageState();
}

class _PhoneToForeheadPageState extends State<PhoneToForeheadPage> {
  int countdown = 3;
  Timer? _timer;
  StreamSubscription? _accelerometerSubscription;
  bool countdownStarted = false; // Sayım başladı mı kontrolü

  // Target ranges
  final double minX = 7;
  final double maxX = 10;
  final double minY = -5;
  final double maxY = 5;
  final double minZ = -4;
  final double maxZ = 5;

  @override
  void initState() {
    super.initState();

    // Force landscape orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    _accelerometerSubscription = accelerometerEvents.listen((event) {
      if (!countdownStarted) {
        bool inPositionNow =
            event.x >= minX &&
            event.x <= maxX &&
            event.y >= minY &&
            event.y <= maxY &&
            event.z >= minZ &&
            event.z <= maxZ;

        if (inPositionNow) {
          countdownStarted = true;
          startCountdown();
        }
      }
    });
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--;
      });
      if (countdown == 0) {
        _timer?.cancel();
        navigateToGame();
      }
    });
  }

  void navigateToGame() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GamePage()),
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: countdownStarted
            ? Text(
                '$countdown',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              )
            : const Text(
                'TELEFONU ALNINA YERLEŞTİRİN',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
