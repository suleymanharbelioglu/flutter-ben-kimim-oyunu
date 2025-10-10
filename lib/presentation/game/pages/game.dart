import 'dart:async';
import 'package:ben_kimim/common/helper/sound/sound.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/max_round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/status_text_cubit.dart';
import 'package:ben_kimim/presentation/game/pages/game_end.dart';
import 'package:ben_kimim/presentation/game/widgets/game_timer.dart';
import 'package:ben_kimim/presentation/game/widgets/random_name.dart';
import 'package:ben_kimim/presentation/game/widgets/score.dart';
import 'package:ben_kimim/presentation/home/pages/home.dart';
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
  bool _isTilted = false;
  bool _isTimeUp = false;

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

    return WillPopScope(
      onWillPop: () async {
        _pauseGame(); // fiziksel geri tuşuna basıldığında çalışacak
        return false; // sayfadan çıkışı engelle
      },
      child: BlocBuilder<BackgroundColorCubit, Color>(
        builder: (context, backgroundColor) {
          return BlocBuilder<StatusTextCubit, String?>(
            builder: (context, statusText) {
              return Scaffold(
                backgroundColor: backgroundColor,
                body: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GameTimer(remainingSeconds: _remainingSeconds),
                          if (statusText != null)
                            Text(
                              statusText,
                              style: const TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          else
                            const RandomName(),
                          Score(currentPlayer: currentPlayer),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: _pauseGame,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);

        // Son 3 saniyede uyarı sesi çal
        if (_remainingSeconds == 5) {
          await SoundHelper.playLastSeconds();
        }
      } else {
        _timer?.cancel();
        await _finishTurn();
      }
    });
  }

  void _listenAccelerometer() {
    _accelerometerSub = accelerometerEvents.listen((event) {
      if (_isTimeUp) return; // Süre bitti ise hareketleri ignore et

      final z = event.z;

      if (!_isTilted && z <= -8 && z >= -11) {
        _isTilted = true;
        _handleCorrect();
      } else if (!_isTilted && z >= 8 && z <= 11) {
        _isTilted = true;
        _handlePass();
      } else if (_isTilted && z.abs() < 6) {
        _resetState();
      }
    });
  }

  Future<void> _handleCorrect() async {
    await SoundHelper.playCorrect();
    final currentPlayer = context.read<CurrentPlayerCubit>().currentPlayer;
    context.read<PlayersListedByScoreCubit>().increaseScore(currentPlayer, 1);
    _showTempState("Doğru!", Colors.green);
  }

  Future<void> _handlePass() async {
    await SoundHelper.playPass();
    _showTempState("Pas!", Colors.red);
  }

  void _showTempState(String text, Color color) {
    context.read<StatusTextCubit>().show(text);
    context.read<BackgroundColorCubit>().setColor(color);
  }

  void _resetState() {
    _isTilted = false;
    context.read<StatusTextCubit>().hide();
    context.read<BackgroundColorCubit>().reset();
    context.read<DisplayRandomFamousCubit>().fetchRandom();
  }

  void _pauseGame() {
    _timer?.cancel();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Oyunu duraklat"),
        content: const Text(
          "Devam etmek mi yoksa ana sayfaya dönmek mi istersin?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startTimer();
            },
            child: const Text("Devam Et"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);

              AppNavigator.pushReplacement(context, HomePage());
            },
            child: const Text("Ana Sayfa"),
          ),
        ],
      ),
    );
  }

  Future<void> _finishTurn() async {
    await _showTimeUpScreen();

    if (!mounted) return;

    final currentIndex = context.read<CurrentPlayerCubit>().state;
    final allPlayersLength = context.read<AllPlayersCubit>().state.length;
    final roundCubit = context.read<RoundCubit>();
    final maxRound = context.read<MaxRoundCubit>().state;
    context.read<BackgroundColorCubit>().reset();
    context.read<StatusTextCubit>().hide();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    if (currentIndex < allPlayersLength - 1) {
      context.read<CurrentPlayerCubit>().nextPlayer();
      AppNavigator.pushReplacement(context, const ScorePage());
    } else {
      if (roundCubit.state >= maxRound) {
        context.read<RoundCubit>().resetRound();
        AppNavigator.pushAndRemove(context, GameEndPage());
      } else {
        roundCubit.nextRound();
        context.read<CurrentPlayerCubit>().setInitial(0);
        AppNavigator.pushReplacement(context, const ScorePage());
      }
    }
  }

  Future<void> _showTimeUpScreen() async {
    if (!mounted) return;

    _isTimeUp = true; // Süre bitti modu aktif

    context.read<BackgroundColorCubit>().setColor(Colors.yellow);
    context.read<StatusTextCubit>().show("Süre Bitti!");
    await SoundHelper.playTimeUp();

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    _isTimeUp = false; // Süre bitti modu kapat
  }
}
