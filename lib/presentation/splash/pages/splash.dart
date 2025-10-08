import 'package:ben_kimim/common/helper/splash/splash_navigator.dart';
import 'package:ben_kimim/core/configs/theme/app_colors.dart';
import 'package:ben_kimim/presentation/home/pages/home.dart';
import 'package:ben_kimim/presentation/splash/bloc/load_cached_famous_cubit.dart';
import 'package:ben_kimim/presentation/splash/bloc/load_cached_famous_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/presentation/error/pages/error.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // arka plan tutarlı
      body: Center(
        child: BlocListener<LoadCachedFamousCubit, LoadCachedFamousState>(
          listener: (context, state) {
            if (state is LoadCachedFamousSuccess) {
              SplashNavigator.navigate(context, HomePage());
            } else if (state is LoadCachedFamousError) {
              SplashNavigator.navigate(
                context,
                ErrorPage(message: state.message),
              );
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary, // logo rengi primary
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text("🎯", style: TextStyle(fontSize: 48)),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Ben Kimim?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // yazı primary
                ),
              ),
              const SizedBox(height: 16),
              CircularProgressIndicator(
                color: AppColors.secondary, // loading secondary
              ),
            ],
          ),
        ),
      ),
    );
  }
}
