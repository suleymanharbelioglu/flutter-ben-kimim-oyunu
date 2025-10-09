import 'package:ben_kimim/data/famous/sources/famous_name_service.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/service_locator.dart';

class FamousRepositoryImpl extends FamousRepository {
  @override
  String getRandomName() {
    return sl<FamousNameService>().getRandomName();
  }
}
