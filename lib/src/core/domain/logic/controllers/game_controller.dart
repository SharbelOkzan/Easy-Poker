import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/calculate_game_results_usecase.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/exchange_card_usecase.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/get_shuffled_deck_usecase.dart';

abstract class GameController {
  GameController(
      {required GetShuffledDeckUsecase getShuffeledDeck,
      required CalculateGameResultsUsecase calculateGameResults,
      required ExchangeCardUsecase exchangeCard})
      : _calculateGameResults = calculateGameResults,
        _exchangeCard = exchangeCard;

  final CalculateGameResultsUsecase _calculateGameResults;
  final ExchangeCardUsecase _exchangeCard;

  Game get game;
  set game(Game game);

  Player? get currentActivePlayer;

  void exchangeCards(List<int> selectedCardsForExchangeIndecies) {
    if (currentActivePlayer == null) return; //TODO remove this, it's redundant
    Game updatedGame;
    List<Card> updatedHand = List.from(currentActivePlayer!.cards);
    List<Card> updatedDeck = List.from(game.deck);
    for (int cardToExchangeIndex in selectedCardsForExchangeIndecies) {
      (updatedDeck, updatedHand) = _exchangeCard((
        deck: updatedDeck,
        hand: updatedHand,
        cardToExchangeIndex: cardToExchangeIndex
      ));
    }

    updatedGame = _getGameWithUpdatedCurrentPlayerHand(game, updatedHand);
    game = updatedGame.copyWith(deck: updatedDeck);
  }

  endCurrentGamePhase() {
    GamePhase nextGamePhase;
    GamePhase currentPhase = game.phase;

    switch (currentPhase) {
      case OfflineGamePhase():
        nextGamePhase = _getNextOfflineGamePhase(currentPhase);
      case OnlineGamePhase():
        nextGamePhase = _getNextOnlineGamePhase(currentPhase);
    }
    game = game.copyWith(phase: nextGamePhase);
  }

  OfflineGamePhase _getNextOfflineGamePhase(OfflineGamePhase phase) {
    OfflineGamePhase nextGamePhase;
    switch (phase) {
      case OfflineGameRunning():
        final currentActivePlayerId = phase.currentActivePlayerId;
        switch (currentActivePlayerId) {
          case PlayerId.p1:
            nextGamePhase = OfflineGameRunning(currentActivePlayerId: null);
          case null:
            nextGamePhase =
                OfflineGameRunning(currentActivePlayerId: PlayerId.p2);
          case PlayerId.p2:
            nextGamePhase = _getGameEndedPhase(phase);
        }

      case GameEndedPhase():
        throw UnimplementedError("User can't end this phase manually");
    }
    return nextGamePhase;
  }

  OnlineGamePhase _getNextOnlineGamePhase(OnlineGamePhase phase) {
    OnlineGamePhase nextGamePhase;

    switch (phase) {
      case GameWaitingForPlayer():
        throw UnimplementedError("User can't end this phase manually");
      case OnlineGameRunning():
        Map<PlayerId, bool> playersTurnsStatus = phase.playersTurnsStatus;
        final bool allPlayersFinished =
            phase.playersTurnsStatus.values.every((e) => e);
        if (allPlayersFinished) {
          nextGamePhase = _getGameEndedPhase(phase);
        } else {
          playersTurnsStatus[currentActivePlayer!.id] = true;
          nextGamePhase = phase.copyWith(playersTurnsStatus);
        }
      case GameEndedPhase():
        throw UnimplementedError("User can't end this phase manually");
    }
    return nextGamePhase;
  }

  GameEndedPhase _getGameEndedPhase(GamePhase phase) {
    Player winner, looser;
    (winner: winner, looser: looser) =
        _calculateGameResults((game.player1, game.player2));
    return GameEndedPhase(winner: winner, looser: looser);
  }

  Game _getGameWithUpdatedCurrentPlayerHand(Game game, List<Card> updatedHand) {
    if (currentActivePlayer == game.player1) {
      return game.copyWith.player1(cards: updatedHand);
    } else {
      return game.copyWith.player2(cards: updatedHand);
    }
  }
}
