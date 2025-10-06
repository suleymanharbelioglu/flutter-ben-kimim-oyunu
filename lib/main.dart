import 'package:ben_kimim/firebase_options.dart';
import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/splash/bloc/load_cached_famous_cubit.dart';
import 'package:ben_kimim/presentation/splash/pages/splash.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FamousHelper.addFamousNames();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
        BlocProvider<LoadCachedFamousCubit>(
          create: (context) => LoadCachedFamousCubit()..loadCache(),
        ),
        BlocProvider<DisplayRandomFamousCubit>(
          create: (context) => DisplayRandomFamousCubit()..fetchRandom(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ben Kimim Oyunu',
        home: const SplashPage(),
      ),
    );
  }
}
