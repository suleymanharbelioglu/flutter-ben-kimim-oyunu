import 'package:flutter_bloc/flutter_bloc.dart';

class RoundCubit extends Cubit<int> {
  RoundCubit() : super(1); // Oyun 1. turdan başlar

  void nextRound() => emit(state + 1);

  void resetRound() => emit(1);
}