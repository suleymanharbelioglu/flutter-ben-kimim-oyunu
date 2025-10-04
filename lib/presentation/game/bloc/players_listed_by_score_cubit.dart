import 'package:ben_kimim/domain/player/entity/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersListedByScoreCubit extends Cubit<List<PlayerEntity>> {
  PlayersListedByScoreCubit(List<PlayerEntity> initialPlayers)
    : super(List.from(initialPlayers));

  // Set players list
  void setPlayers(List<PlayerEntity> players) {
    emit(List.from(players));
  }

  void updateScore(PlayerEntity player, int newScore) {
    final updatedList = state.map((p) {
      if (p.name == player.name) {
        // <- burada
        return PlayerEntity(name: p.name, score: newScore);
      }
      return p;
    }).toList();

    // Sort players by score descending
    updatedList.sort((a, b) => b.score.compareTo(a.score));
    emit(updatedList);
  }

  // Increase player's score by amount
  void increaseScore(PlayerEntity player, int amount) {
    final current = state.firstWhere((p) => p.name == player.name);
    updateScore(player, current.score + amount);
  }

  // Reset all scores
  void resetScores() {
    final resetList = state.map((p) => PlayerEntity(name: p.name)).toList();
    emit(resetList);
  }
}
