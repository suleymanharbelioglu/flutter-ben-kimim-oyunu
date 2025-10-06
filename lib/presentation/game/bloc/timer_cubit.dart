import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(90); // default: 60 saniye

  void setDuration(int seconds) => emit(seconds);
}
