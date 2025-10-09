abstract class UserSettingsRepo {
    Future<void> saveGameDuration(int seconds);
  Future<void> saveMaxRound(int round);
  Future<int?> getGameDuration();
  Future<int?> getMaxRound();
  Future<void> clearSettings();
}