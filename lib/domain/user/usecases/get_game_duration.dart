import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/user/repository/user_settings_repo.dart';
import 'package:ben_kimim/service_locator.dart';

class GetGameDurationUseCase implements UseCase<int?, dynamic> {
  @override
  Future<int?> call({dynamic params}) async {
    return sl<UserSettingsRepo>().getGameDuration();
  }
}
