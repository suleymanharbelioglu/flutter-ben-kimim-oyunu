import 'package:ben_kimim/common/helper/splash/splash_navigator.dart';
import 'package:ben_kimim/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashNavigator.navigate(context, HomePage());
    return Scaffold(body: Center(child: Text("App Icon")));
  }
}
