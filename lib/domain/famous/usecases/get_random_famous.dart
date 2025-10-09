import 'package:ben_kimim/core/usecase/usecase.dart';
import 'package:ben_kimim/domain/famous/repository/famous_repository.dart';
import 'package:ben_kimim/service_locator.dart';

class GetRandomFamousNameUseCase implements UseCase<String, dynamic> {
  @override
  Future<String> call({dynamic params}) async {
    // SL'den servisi çağırıp random isim döndür
    return sl<FamousRepository>().getRandomName();
  }
}
