import '../player.dart';

sealed class GameStatus {}

class GameRunning extends GameStatus {}

class GameEnded extends GameStatus {
  final Player winner;
  final Player looser;

  GameEnded({required this.winner, required this.looser});
}
