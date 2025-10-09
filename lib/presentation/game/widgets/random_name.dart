import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/presentation/game/bloc/display_random_famous_cubit.dart';

class RandomName extends StatelessWidget {
  const RandomName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DisplayRandomFamousCubit, String?>(
      builder: (context, famous) {
        final displayText = famous ?? "Loading...";
        return Text(
          displayText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 70, // büyük ve göze çarpan
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2, // biraz ferahlık
            shadows: [
              // hafif gölge ile okunabilirlik
              Shadow(
                blurRadius: 4,
                color: Colors.black45,
                offset: Offset(2, 2),
              ),
            ],
          ),
        );
      },
    );
  }
}
