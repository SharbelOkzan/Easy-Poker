import 'package:easy_poker/src/core/domain/entities/enums/game_status.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/logic/usecases/get_shuffled_deck_usecase.dart';
import '../../domain/entities/card.dart';
import '../../domain/logic/usecases/calculate_game_results_usecase.dart';
import '../../domain/logic/usecases/exchage_card_usecase.dart';

final gameProvider = NotifierProvider<GameNotifier, Game>(() => GameNotifier(
      getShuffeledDeck: getIt.get(),
      calculateGameResults: getIt.get(),
      exchangeCard: getIt.get(),
    ));

// using `Notifier` instead of `StateNotifier`
// based on lib author recomendation
// https://stackoverflow.com/a/76323140/15690446
class GameNotifier extends Notifier<Game> {
  final GetShuffeledDeckUsecase _getShuffeledDeck;
  final CalculateGameResultsUsecase _calculateGameResults;
  final ExchangeCardUsecase _exchangeCard;
  GameNotifier({
    required GetShuffeledDeckUsecase getShuffeledDeck,
    required CalculateGameResultsUsecase calculateGameResults,
    required ExchangeCardUsecase exchangeCard,
  })  : _calculateGameResults = calculateGameResults,
        _exchangeCard = exchangeCard,
        _getShuffeledDeck = getShuffeledDeck;

  Player? get _playerInTurn {
    if (state.status is GameRunning) {
      if ((state.status as GameRunning).playerInTurnId == state.player1.id) {
        return state.player1;
      }
      if ((state.status as GameRunning).playerInTurnId == state.player2.id) {
        return state.player2;
      }
    }
    return null;
  }

  List<Card>? get cardsToShow => _playerInTurn?.cards;

  @override
  Game build() {
    List<Card> deck = _getShuffeledDeck();
    List<Card> firstPlayerCards = deck.sublist(0, 5);
    deck.removeRange(0, 5);
    List<Card> secondPlayerCards = deck.sublist(0, 5);
    deck.removeRange(0, 5);
    assert(deck.length == 42);
    Player player1 = Player(cards: firstPlayerCards, id: 1);
    Player player2 = Player(cards: secondPlayerCards, id: 2);
    Game game = Game(
        player1: player1,
        player2: player2,
        deck: deck,
        status: GameRunning(playerInTurnId: 1),
        selectedCardsForExchangeIndecies: []);
    return game;
  }

  selectCardForExchange(int cardIndex) {
    List<int> updatedSelectedCardsForExchage = [
      ...state.selectedCardsForExchangeIndecies
    ];
    if (state.selectedCardsForExchangeIndecies.contains(cardIndex)) {
      updatedSelectedCardsForExchage.remove(cardIndex);
    } else {
      updatedSelectedCardsForExchage.add(cardIndex);
    }
    state = state.copyWith(
        selectedCardsForExchangeIndecies: updatedSelectedCardsForExchage);
  }

  exchangeCards() {
    if (_playerInTurn == null) {
      return;
    }
    List<Card> updatedHand = _playerInTurn!.cards;
    List<Card> updatedDeck = state.deck;
    for (int cardToExchangeIndex in state.selectedCardsForExchangeIndecies) {
      (updatedDeck, updatedHand) = _exchangeCard((
        deck: updatedDeck,
        hand: updatedHand,
        cardToExchangeIndex: cardToExchangeIndex
      ));
    }
    // One may argue that if storing the players in a list
    // instead of two vars (player1, player2), will help in avoiding
    // this wierd is/else block bellow. But actually storing players
    // in a list would've led to wierd code in many other places
    if (_playerInTurn == state.player1) {
      state = state.copyWith.player1(cards: updatedHand);
    } else {
      state = state.copyWith.player2(cards: updatedHand);
    }
    state = state.copyWith(
        deck: updatedDeck, selectedCardsForExchangeIndecies: List<int>.empty());
  }

  // TODO to endCurrentGamePhase and introduce an enum for possible game phases
  endPlayerTurn() {
    GameStatus newGameStatus;
    // player1 turn ==> nullify the turn until the
    // players hands over the phone to the other player
    if (_playerInTurn == state.player1) {
      newGameStatus =
          (state.status as GameRunning).copyWith(playerInTurnId: () => null);
      // no one's turn ==> start player2 turn
    } else if (_playerInTurn == null) {
      newGameStatus =
          (state.status as GameRunning).copyWith(playerInTurnId: () => 2);
      // player2 turn ==> game is over, show results
    } else if (_playerInTurn == state.player2) {
      Player winner, looser;
      (winner: winner, looser: looser) =
          _calculateGameResults((state.player1, state.player2));
      newGameStatus = GameEnded(winner: winner, looser: looser);
    } else {
      throw "Should not be possible";
    }
    state = state.copyWith(status: newGameStatus);
  }

  startSecondPlayerTurn() {}
}
