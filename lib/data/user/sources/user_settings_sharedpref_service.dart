import 'package:shared_preferences/shared_preferences.dart';

abstract class UserSettingsSharedprefService {
  Future<void> saveGameDuration(int seconds);
  Future<void> saveMaxRound(int round);
  Future<int?> getGameDuration();
  Future<int?> getMaxRound();
  Future<void> clearSettings();
}

class UserSettingsSharedprefServiceImpl extends UserSettingsSharedprefService {
  static const String _gameDurationKey = 'game_duration';
  static const String _maxRoundKey = 'max_round';

  @override
  Future<void> saveGameDuration(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_gameDurationKey, seconds);
  }

  @override
  Future<void> saveMaxRound(int round) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_maxRoundKey, round);
  }

  @override
  Future<int?> getGameDuration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_gameDurationKey);
  }

  @override
  Future<int?> getMaxRound() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_maxRoundKey);
  }

  @override
  Future<void> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_gameDurationKey);
    await prefs.remove(_maxRoundKey);
  }
}
