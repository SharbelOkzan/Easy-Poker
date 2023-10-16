import 'package:freezed_annotation/freezed_annotation.dart';

import '../player.dart';

sealed class GameStatus {
  GameStatus();
  factory GameStatus.fromJson(Map<String, dynamic> json) {
    switch (json['subtype']) {
      case "game_running":
        int playerinTurnId = json["player_in_turn_id"];
        return GameRunning(playerInTurnId: playerinTurnId);
      case "game_ended":
        Player winner = Player.fromJson(json['player']);
        Player looser = Player.fromJson(json['looser']);
        return GameEnded(winner: winner, looser: looser);
      default:
        throw UnsupportedError(
            'deserilization failed deu to unknow subtype of GameStatus \n supported types are [game_running, game_ended], found ${json['subtype']}');
    }
  }

  Map<String, dynamic> toJson() {
    String subtype;
    Map<String, dynamic> json = {};
    switch (this) {
      case GameRunning():
        subtype = 'game_running';
      case GameEnded():
        subtype = 'game_ended';
    }
    json['subtype'] = subtype;

    switch (this) {
      case GameRunning():
        json['player_in_turn_id'] = (this as GameRunning).playerInTurnId;
      case GameEnded():
        json['winner'] = (this as GameEnded).winner;
        json['looser'] = (this as GameEnded).looser;
    }
    return json;
  }
}

class GameRunning extends GameStatus {
  final int? playerInTurnId;

  GameRunning({required this.playerInTurnId});

  GameRunning copyWith({
    int? Function()? playerInTurnId,
  }) {
    return GameRunning(
      playerInTurnId:
          playerInTurnId != null ? playerInTurnId() : this.playerInTurnId,
    );
  }
}

class GameEnded extends GameStatus {
  final Player winner;
  final Player looser;

  GameEnded({required this.winner, required this.looser});
}
