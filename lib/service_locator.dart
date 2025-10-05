import 'package:ben_kimim/data/famous/repository/famous_repository_impl.dart';
import 'package:ben_kimim/data/famous/sources/famous_firebase_service.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/domain/famous/usecases/get_famous_random_cache.dart';
import 'package:ben_kimim/domain/famous/usecases/load_famous_cache.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //repositories
  sl.registerSingleton<FamousRepository>(FamousRepositoryImpl());

  //sources

  sl.registerSingleton<FamousFirebaseService>(FamousFirebaseServiceImpl());

  //usecases
  sl.registerSingleton<LoadFamousCacheUseCase>(LoadFamousCacheUseCase());
  sl.registerSingleton<GetFamousRandomCacheUseCase>(
    GetFamousRandomCacheUseCase(),
  );
}
