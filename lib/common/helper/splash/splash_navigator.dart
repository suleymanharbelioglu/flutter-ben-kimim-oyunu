import 'package:ben_kimim/common/navigator/app_navigator.dart';
import 'package:flutter/widgets.dart';

class SplashNavigator {
  static Future<void> navigate(BuildContext context, Widget widget) async {
    await Future.delayed(Duration(seconds: 3));
    AppNavigator.pushReplacement(context, widget);
  }
}
