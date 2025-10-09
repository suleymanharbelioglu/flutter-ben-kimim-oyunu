import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _startSplash();
  }

  void _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(SplashNavigate());
  }
}
