import 'package:ben_kimim/data/famous/repository/famous_repository_impl.dart';
import 'package:ben_kimim/data/famous/sources/famous_firebase_service.dart';
import 'package:ben_kimim/data/user/repository/user_settings_repo_impl.dart';
import 'package:ben_kimim/data/user/sources/user_settings_sharedpref_service.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/domain/famous/usecases/get_famous_random_cache.dart';
import 'package:ben_kimim/domain/famous/usecases/load_famous_cache.dart';
import 'package:ben_kimim/domain/user/repository/user_settings_repo.dart';
import 'package:ben_kimim/domain/user/usecases/clear_settings.dart';
import 'package:ben_kimim/domain/user/usecases/get_game_duration.dart';
import 'package:ben_kimim/domain/user/usecases/get_max_round.dart';
import 'package:ben_kimim/domain/user/usecases/save_game_duration.dart';
import 'package:ben_kimim/domain/user/usecases/save_max_round.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  sl.registerSingleton<FamousRepository>(FamousRepositoryImpl());
  sl.registerSingleton<UserSettingsRepo>(UserSettingsRepoImpl());

  // Sources
  sl.registerSingleton<FamousFirebaseService>(FamousFirebaseServiceImpl());
  sl.registerSingleton<UserSettingsSharedprefService>(
    UserSettingsSharedprefServiceImpl(),
  );

  // Usecases - Famous
  sl.registerSingleton<LoadFamousCacheUseCase>(LoadFamousCacheUseCase());
  sl.registerSingleton<GetFamousRandomCacheUseCase>(
    GetFamousRandomCacheUseCase(),
  );

  // Usecases - User Settings
  sl.registerSingleton<SaveMaxRoundUseCase>(SaveMaxRoundUseCase());
  sl.registerSingleton<SaveGameDurationUseCase>(SaveGameDurationUseCase());
  sl.registerSingleton<GetMaxRoundUseCase>(GetMaxRoundUseCase());
  sl.registerSingleton<GetGameDurationUseCase>(GetGameDurationUseCase());
  sl.registerSingleton<ClearSettingsUseCase>(ClearSettingsUseCase());
}
