import 'package:ben_kimim/presentation/game/bloc/all_players_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/current_player_cubit.dart';
import 'package:ben_kimim/presentation/game/bloc/players_listed_by_score_cubit.dart';
import 'package:ben_kimim/presentation/splash/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

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
          create: (context) =>
              CurrentPlayerCubit(),
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
