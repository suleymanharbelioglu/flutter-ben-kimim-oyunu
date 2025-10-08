import 'package:flutter_bloc/flutter_bloc.dart';

class MaxRoundCubit extends Cubit<int> {
  MaxRoundCubit() : super(5); // Varsayılan max tur 5

  void setMaxRound(int newMax) => emit(newMax);
}