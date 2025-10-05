import 'package:ben_kimim/data/famous/sources/famous_firebase_service.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:dartz/dartz.dart';

class FamousRepositoryImpl extends FamousRepository {
  @override
  Future<Either> loadCache() async {
    return await sl<FamousFirebaseService>().loadCache();
  }
  
  @override
  FamousEntity getRandomFromCache() {
    return sl<FamousFirebaseService>().getRandomFromCache();
  }
}
