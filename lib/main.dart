import 'package:ben_kimim/core/configs/theme/app_theme.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/background_color_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/max_round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/round_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/status_text_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/timer_cubit.dart';
import 'package:ben_kimim/presentation/splash/pages/splash.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Cubit to store all players
        BlocProvider<AllPlayersCubit>(create: (_) => AllPlayersCubit()),
        // Cubit to manage scores and sort players by score
        BlocProvider<PlayersListedByScoreCubit>(
          create: (context) =>
              PlayersListedByScoreCubit(context.read<AllPlayersCubit>().state),
        ),
        // Cubit to track the current player index
        BlocProvider<CurrentPlayerCubit>(
          create: (context) => CurrentPlayerCubit(),
        ),

        BlocProvider<DisplayRandomFamousCubit>(
          create: (context) => DisplayRandomFamousCubit()..fetchRandom(),
        ),
        BlocProvider<TimerCubit>(create: (context) => TimerCubit()),
        BlocProvider<BackgroundColorCubit>(
          create: (context) => BackgroundColorCubit(),
        ),
        BlocProvider<StatusTextCubit>(create: (context) => StatusTextCubit()),
        BlocProvider<RoundCubit>(create: (context) => RoundCubit()),
        BlocProvider<MaxRoundCubit>(create: (context) => MaxRoundCubit()),
      ],
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        title: 'Ben Kimim Oyunu',
        home: const SplashPage(),
      ),
    );
  }
}
