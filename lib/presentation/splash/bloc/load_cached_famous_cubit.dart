// Cubit
import 'package:ben_kimim/domain/famous/usecases/load_famous_cache.dart';
import 'package:ben_kimim/presentation/splash/bloc/load_cached_famous_state.dart';
import 'package:ben_kimim/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class LoadCachedFamousCubit extends Cubit<LoadCachedFamousState> {
  LoadCachedFamousCubit() : super(LoadCachedFamousInitial());

  Future<void> loadCache() async {
    emit(LoadCachedFamousLoading());

    final Either result = await sl<LoadFamousCacheUseCase>().call();

    result.fold(
      (error) => emit(LoadCachedFamousError(error)), // Hata varsa
      (_) => emit(LoadCachedFamousSuccess()), // Başarılıysa
    );
  }
}