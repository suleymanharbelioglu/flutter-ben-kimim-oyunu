import 'package:ben_kimim/common/helper/splash/splash_navigator.dart';
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
      body: Center(
        child: BlocListener<LoadCachedFamousCubit, LoadCachedFamousState>(
          listener: (context, state) {
            if (state is LoadCachedFamousSuccess) {
              // Cache başarıyla yüklendi → HomePage
              SplashNavigator.navigate(context, HomePage());
            }
            if (state is LoadCachedFamousError) {
              // Cache yüklenemedi → ErrorPage
              SplashNavigator.navigate(
                context,
                ErrorPage(message: state.message),
              );
            }
          },
          child: const Text("App Icon"),
        ),
      ),
    );
  }
}
