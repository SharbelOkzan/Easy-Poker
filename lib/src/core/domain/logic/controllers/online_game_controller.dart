import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_poker/src/core/data/repositories/remote_game_repository.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/game_controller.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<DocumentSnapshot<Game>> remoteGameRefSnapshotsProvider =
    StreamProvider((ref) {
  return ref.read(remoteGameRefProvider).snapshots();
});

Provider<OnlineGameController> onlineGameControllerProvider = Provider((ref) =>
    OnlineGameController(ref,
        getShuffeledDeck: getIt.get(),
        calculateGameResults: getIt.get(),
        exchangeCard: getIt.get()));

class OnlineGameController extends GameController {
  final ProviderRef ref;

  OnlineGameController(this.ref,
      {required super.getShuffeledDeck,
      required super.calculateGameResults,
      required super.exchangeCard});

  @override
  Game get game => ref.read(remoteGameRefSnapshotsProvider).value!.data()!;

  @override
  set game(Game game) => ref.read(remoteGameRefProvider).set(game);

  @override
  Player? get currentActivePlayer {
    PlayerId currentPlayerId =
        ref.read(remoteGameRepositoryProvider).currentPlayerId;
    return game.players.firstWhere((player) => player.id == currentPlayerId);
  }
}
