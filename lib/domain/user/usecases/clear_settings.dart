import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/user/repository/user_settings_repo.dart';
import 'package:ben_kimim/service_locator.dart';

class ClearSettingsUseCase implements UseCase<dynamic, dynamic> {
  @override
  Future<void> call({dynamic params}) async {
    return sl<UserSettingsRepo>().clearSettings();
  }
}