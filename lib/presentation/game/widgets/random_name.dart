import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';

class RandomName extends StatelessWidget {
  const RandomName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayRandomFamousCubit, FamousEntity?>(
      builder: (context, famous) {
        if (famous == null) {
          return const Text(
            "Loading...",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          );
        }
        return Text(
          famous.name,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        );
      },
    );
  }
}
