import 'package:ben_kimim/domain/user/usecases/get_max_round.dart';
import 'package:ben_kimim/domain/user/usecases/save_max_round.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ben_kimim/service_locator.dart';

class MaxRoundCubit extends Cubit<int> {
  MaxRoundCubit() : super(5) {
    _loadMaxRound();
  }

  Future<void> _loadMaxRound() async {
    final savedMax = await sl<GetMaxRoundUseCase>()();
    if (savedMax != null) emit(savedMax);
  }

  Future<void> setMaxRound(int newMax) async {
    emit(newMax);
    await sl<SaveMaxRoundUseCase>()(params: newMax);
  }
}
