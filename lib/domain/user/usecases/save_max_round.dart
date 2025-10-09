import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/user/repository/user_settings_repo.dart';
import 'package:ben_kimim/service_locator.dart';

class SaveMaxRoundUseCase implements UseCase<void, int> {
  @override
  Future<void> call({int? params}) async {
    return sl<UserSettingsRepo>().saveMaxRound(params!);
  }
}
