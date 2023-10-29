import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/create_new_game_usecase/create_new_offline_game_usecase.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameNotifierProvider =
    NotifierProvider<GameNotifier, Game>(() => GameNotifier(
          createNewOfflineGame: getIt.get(),
        ));

// using `Notifier` instead of `StateNotifier`
// based on lib author recommendation
// https://stackoverflow.com/a/76323140/15690446
class GameNotifier extends Notifier<Game> {
  final CreateNewOfflineGameUsecase _createNewOfflineGame;
  GameNotifier({
    required CreateNewOfflineGameUsecase createNewOfflineGame,
  }) : _createNewOfflineGame = createNewOfflineGame;

  updatedGameState(Game game) {
    state = game;
  }

  @override
  Game build() {
    return _createNewOfflineGame();
  }
}
