import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/game_controller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<GameController> offlineGameControllerProvider =
    Provider<GameController>((ref) => OfflineGameController(
          ref: ref,
          getShuffeledDeck: getIt.get(),
          calculateGameResults: getIt.get(),
          exchangeCard: getIt.get(),
        ));

class OfflineGameController extends GameController {
  final ProviderRef ref;

  OfflineGameController(
      {required this.ref,
      required super.getShuffeledDeck,
      required super.calculateGameResults,
      required super.exchangeCard});
  @override
  Game get game => ref.read(gameNotifierProvider);

  @override
  set game(Game game) {
    ref.read(gameNotifierProvider.notifier).updatedGameState(game);
  }

  @override
  Player? get currentActivePlayer {
    OfflineGamePhase phase = game.phase as OfflineGamePhase;
    switch (phase) {
      case OfflineGameRunning():
        if (phase.currentActivePlayerId != null) {
          return game.players
              .firstWhere((player) => player.id == phase.currentActivePlayerId);
        } else {
          // game is at the phase between players turns, so no player is active
          return null;
        }
      case GameEndedPhase():
        return null;
    }
  }
}
