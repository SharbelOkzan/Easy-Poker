import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';

import '../player.dart';

// TODO improve deserialization code
// I had to manually implement the serialization/deserialization for this class
// due to a current limitations in `freezed` regarding sealed classes.
// The code isn't at its best here, please don't pay it too much attention.
sealed class GamePhase {
  static const String _statusKey = 'status';

  GamePhase();
  factory GamePhase.fromJson(Map<String, dynamic> json) {
    switch (json[_statusKey]) {
      case 'GameWaitingForPlayer':
        return GameWaitingForPlayer();
      case 'OnlineGameRunning':
        var playersTurnsStatus =
            json['playersTurnsStatus'] as Map<String, dynamic>;
        Map<PlayerId, bool> playersTurnsStatusDeserialized =
            playersTurnsStatus.map((key, value) =>
                MapEntry(key == 'p1' ? PlayerId.p1 : PlayerId.p2, value));
        return OnlineGameRunning(playersTurnsStatusDeserialized);
      case 'GameEndedPhase':
        Player winner = Player.fromJson(json['winner'] as Map<String, dynamic>);
        Player looser = Player.fromJson(json['looser'] as Map<String, dynamic>);
        return GameEndedPhase(winner: winner, looser: looser);
      default:
        // subclasses of OfflineGamePhase don't need to be deserialized
        throw Exception("Failed to deserialize an unknown GamePhase");
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    switch (this) {
      case OfflineGameRunning():
        json[_statusKey] = 'OfflineGameRunning';
      case GameEndedPhase():
        json[_statusKey] = 'GameEndedPhase';
        json['winner'] = (this as GameEndedPhase).winner.toJson();
        json['looser'] = (this as GameEndedPhase).looser.toJson();
      case GameWaitingForPlayer():
        json[_statusKey] = 'GameWaitingForPlayer';
      case OnlineGameRunning():
        json[_statusKey] = 'OnlineGameRunning';
        json['playersTurnsStatus'] = (this as OnlineGameRunning)
            .playersTurnsStatus
            .map((key, value) => MapEntry(key.name, value));
    }
    return json;
  }
}

sealed class OfflineGamePhase extends GamePhase {}

sealed class OnlineGamePhase extends GamePhase {}

class OfflineGameRunning extends OfflineGamePhase {
  final PlayerId? currentActivePlayerId;

  OfflineGameRunning({required this.currentActivePlayerId});
}

class GameWaitingForPlayer extends OnlineGamePhase {}

class OnlineGameRunning extends OnlineGamePhase {
  final Map<PlayerId, bool> playersTurnsStatus;

  OnlineGameRunning(this.playersTurnsStatus);

  OnlineGameRunning copyWith(Map<PlayerId, bool>? playersTurnsStatus) {
    return OnlineGameRunning(playersTurnsStatus ?? this.playersTurnsStatus);
  }
}

class GameEndedPhase extends OfflineGamePhase implements OnlineGamePhase {
  final Player winner;
  final Player looser;

  GameEndedPhase({required this.winner, required this.looser});
}
