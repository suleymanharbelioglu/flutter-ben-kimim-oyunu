import 'package:ben_kimim/core/configs/theme/app_colors.dart';
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
        final displayText = famous?.name ?? "Loading...";
        return Text(
          displayText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 80, // büyük ve göze çarpan
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
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
