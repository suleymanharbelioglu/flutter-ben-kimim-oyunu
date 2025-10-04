import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPlayerCubit extends Cubit<int> {
  List<PlayerEntity> players = [];

  CurrentPlayerCubit() : super(0);

  PlayerEntity get currentPlayer {
    if (players.isEmpty) {
      throw Exception("No players available");
    }
    return players[state];
  }

  void setPlayers(List<PlayerEntity> newPlayers) {
    players = newPlayers;
    emit(0); // reset index to first player
  }

  void nextPlayer() {
    if (players.isEmpty) return;
    emit((state + 1) % players.length);
  }

  void setInitial(int index) {
    if (index >= 0 && index < players.length) {
      emit(index);
    }
  }

  void reset() {
    emit(0);
  }
}
