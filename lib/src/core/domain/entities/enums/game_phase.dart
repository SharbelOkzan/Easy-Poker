import '../player.dart';

sealed class GamePhase {
  GamePhase();
  factory GamePhase.fromJson(Map<String, dynamic> json) {
    throw "TODO";
  }
  Map<String, dynamic> toJson() {
    throw "TODO";
  }
}

sealed class OfflineGamePhase extends GamePhase {}

sealed class OnlineGamePhase extends GamePhase {}

class FirstPlayerTurnPhase extends OfflineGamePhase {}

class BetweenTurnsPhase extends OfflineGamePhase {}

class SecondPlayerTurnPhase extends OfflineGamePhase {}

class GameRunning extends OnlineGamePhase {
  final Map<int, bool> playersTurnsStatus;

  GameRunning(this.playersTurnsStatus);

  GameRunning copyWith(Map<int, bool>? playersTurnsStatus) {
    return GameRunning(playersTurnsStatus ?? this.playersTurnsStatus);
  }
}

class GameEndedPhase extends OfflineGamePhase implements OnlineGamePhase {
  final Player winner;
  final Player looser;

  GameEndedPhase({required this.winner, required this.looser});
}
