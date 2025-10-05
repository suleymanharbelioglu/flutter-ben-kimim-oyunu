import 'package:ben_kimim/domain/famous/entity/famous.dart';
import 'package:ben_kimim/domain/famous/usecases/get_famous_random_cache.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayRandomFamousCubit extends Cubit<FamousEntity?> {
  DisplayRandomFamousCubit() : super(null);

  Future<void> fetchRandom() async {
    debugPrint("new famous -----------------------------");
    // Usecase'den direkt random FamousEntity al
    final famous = await sl<GetFamousRandomCacheUseCase>().call();
    // Cubit state olarak güncelle
    emit(famous);
  }
}
