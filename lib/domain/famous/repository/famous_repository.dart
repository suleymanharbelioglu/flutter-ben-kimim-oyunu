import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:dartz/dartz.dart';

abstract class FamousRepository {
  Future<Either> loadCache();
    FamousEntity getRandomFromCache();

  
}