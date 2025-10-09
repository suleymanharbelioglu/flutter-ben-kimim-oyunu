import 'package:ben_kimim/data/user/sources/user_settings_sharedpref_service.dart';
import 'package:ben_kimim/domain/user/repository/user_settings_repo.dart';
import 'package:ben_kimim/service_locator.dart';

class UserSettingsRepoImpl extends UserSettingsRepo {
  @override
  Future<void> clearSettings() async {
    return await sl<UserSettingsSharedprefService>().clearSettings();
  }

  @override
  Future<int?> getGameDuration() async {
    return await sl<UserSettingsSharedprefService>().getGameDuration();
  }

  @override
  Future<int?> getMaxRound() async {
    return await sl<UserSettingsSharedprefService>().getMaxRound();
  }

  @override
  Future<void> saveGameDuration(int seconds) async {
    return await sl<UserSettingsSharedprefService>().saveGameDuration(seconds);
  }

  @override
  Future<void> saveMaxRound(int round) async {
    return await sl<UserSettingsSharedprefService>().saveMaxRound(round);
  }
}
