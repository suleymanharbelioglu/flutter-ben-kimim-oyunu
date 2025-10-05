
import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:dartz/dartz.dart';

class LoadFamousCacheUseCase  implements UseCase<Either,dynamic>{
  @override
  Future<Either> call({params}) async {
   return await sl<FamousRepository>().loadCache();
  }
}