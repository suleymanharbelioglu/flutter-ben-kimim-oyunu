import 'dart:async';
import 'package:ben_kimim/presentation/game/bloc/status_text_cubit.dart';
import 'package:ben_kimim/presentation/game/widgets/game_timer.dart';
import 'package:ben_kimim/presentation/game/widgets/random_name.dart';
import 'package:ben_kimim/presentation/game/widgets/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/timer_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/background_color_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/score.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Timer? _timer;
  late int _remainingSeconds;
  StreamSubscription? _accelerometerSub;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    _remainingSeconds = context.read<TimerCubit>().state;
    _startTimer();
    _listenAccelerometer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _accelerometerSub?.cancel();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayer = context.watch<CurrentPlayerCubit>().currentPlayer;

    return BlocBuilder<BackgroundColorCubit, Color>(
      builder: (context, backgroundColor) {
        return BlocBuilder<StatusTextCubit, String?>(
          builder: (context, statusText) {
            return Scaffold(
              backgroundColor: backgroundColor,
              body: Center(
                child: statusText != null
                    ? Text(
                        statusText,
                        style: const TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Timer
                          GameTimer(remainingSeconds: _remainingSeconds),

                          // Famous Name
                          const RandomName(),

                          // Score
                          Score(currentPlayer: currentPlayer),
                        ],
                      ),
              ),
            );
          },
        );
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _timer?.cancel();
        _finishTurn();
      }
    });
  }

  void _listenAccelerometer() {
    _accelerometerSub = accelerometerEvents.listen((event) {
      if (_isProcessing) return;

      final x = event.x;
      final y = event.y;
      final z = event.z;

      if (x.abs() < 3 && y.abs() < 5 && z <= -9 && z >= -11) {
        _handleCorrect();
      } else if (x.abs() < 3 && y.abs() < 5 && z >= 9 && z <= 11) {
        _handlePass();
      }
    });
  }

  void _handleCorrect() {
    final currentPlayer = context.read<CurrentPlayerCubit>().currentPlayer;
    context.read<PlayersListedByScoreCubit>().increaseScore(currentPlayer, 1);
    _showTempState("Doğru!", Colors.green);
  }

  void _handlePass() {
    _showTempState("Pas!", Colors.red);
  }

  void _showTempState(String text, Color color) {
    _isProcessing = true;
    context.read<StatusTextCubit>().show(text);
    context.read<BackgroundColorCubit>().setColor(color);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      _isProcessing = false;
      context.read<StatusTextCubit>().hide();
      context.read<BackgroundColorCubit>().reset();
      context.read<DisplayRandomFamousCubit>().fetchRandom();
    });
  }

  void _finishTurn() {
    context.read<CurrentPlayerCubit>().nextPlayer();
    AppNavigator.pushReplacement(context, const ScorePage());
  }
}
