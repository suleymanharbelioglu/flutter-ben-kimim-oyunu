import 'package:ben_kimim/domain/famous/usecases/get_random_famous.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:ben_kimim/service_locator.dart';

class DisplayRandomFamousCubit extends Cubit<String?> {
  DisplayRandomFamousCubit() : super(null);

  Future<void> fetchRandom() async {
    debugPrint("new famous -----------------------------");
    // Usecase'den direkt random isim al
    final name = await sl<GetRandomFamousNameUseCase>().call();
    // Cubit state olarak güncelle
    emit(name);
  }
}
