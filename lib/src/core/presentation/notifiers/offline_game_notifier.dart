import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/logic/usecases/get_shuffled_deck_usecase.dart';
import '../../domain/entities/card.dart';
import '../../domain/logic/usecases/calculate_game_results_usecase.dart';
import '../../domain/logic/usecases/exchange_card_usecase.dart';

final gameNotifierProvider =
    NotifierProvider<GameNotifier, Game>(() => GameNotifier(
          getShuffledDeck: getIt.get(),
          calculateGameResults: getIt.get(),
          exchangeCard: getIt.get(),
        ));

// using `Notifier` instead of `StateNotifier`
// based on lib author recomendation
// https://stackoverflow.com/a/76323140/15690446
class GameNotifier extends Notifier<Game> {
  final GetShuffledDeckUsecase _getShuffledDeck;
  GameNotifier({
    required GetShuffledDeckUsecase getShuffledDeck,
    required CalculateGameResultsUsecase calculateGameResults,
    required ExchangeCardUsecase exchangeCard,
  }) : _getShuffledDeck = getShuffledDeck;

  updatedGameState(Game game) {
    state = game;
  }

  @override
  Game build() {
    List<Card> deck = _getShuffledDeck();
    List<Card> firstPlayerCards = deck.sublist(0, 5);
    deck.removeRange(0, 5);
    List<Card> secondPlayerCards = deck.sublist(0, 5);
    deck.removeRange(0, 5);
    assert(deck.length == 42);
    Player player1 = Player(cards: firstPlayerCards, id: PlayerId.p1);
    Player player2 = Player(cards: secondPlayerCards, id: PlayerId.p2);
    Game game = Game(
      player1: player1,
      player2: player2,
      deck: deck,
      phase: OfflineGameRunning(currentActivePlayerId: PlayerId.p1),
    );
    return game;
  }
}
