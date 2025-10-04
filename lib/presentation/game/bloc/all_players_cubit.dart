import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlayersCubit extends Cubit<List<PlayerEntity>> {
  AllPlayersCubit() : super([]);



  // Birden fazla oyuncu ekleme
  void addPlayers(List<PlayerEntity> players) {
    final updatedList = List<PlayerEntity>.from(state)..addAll(players);
    emit(updatedList);
  }


  // Tüm listeyi temizleme
  void clearPlayers() {
    emit([]);
  }
}
