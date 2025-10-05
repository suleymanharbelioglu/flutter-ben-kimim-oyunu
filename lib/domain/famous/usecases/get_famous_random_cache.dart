import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/service_locator.dart';

class GetFamousRandomCacheUseCase implements UseCase<FamousEntity, dynamic> {
  @override
  Future<FamousEntity> call({params}) async {
    return sl<FamousRepository>().getRandomFromCache();
  }
}
