import 'package:ben_kimim/domain/user/usecases/get_game_duration.dart';
import 'package:ben_kimim/domain/user/usecases/save_game_duration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/service_locator.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(60) {
    _loadDuration(); // Cubit başlar başlamaz telefondan değeri yükle
  }

  // Telefonda kaydedilen süreyi getir
  Future<void> _loadDuration() async {
    final savedDuration = await sl<GetGameDurationUseCase>()();
    if (savedDuration != null) emit(savedDuration);
  }

  // Yeni değeri hem state'e set et hem de telefona kaydet
  Future<void> setDuration(int seconds) async {
    emit(seconds);
    await sl<SaveGameDurationUseCase>()(params: seconds);
  }
}
