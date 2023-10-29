import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/draw_card_usecase.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/get_shuffled_deck_usecase.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/usecase.dart';

abstract class CreateNewGameUseCase extends NoParamsUseCase<Game> {
  static const int _numberOfCardsPerPlayer = 5;

  final DrawCardUsecase _drawCard;
  final GetShuffledDeckUsecase _getShuffledDeck;

  GamePhase get initialPhase;

  CreateNewGameUseCase(
      {required DrawCardUsecase drawCard,
      required GetShuffledDeckUsecase getShuffledDeck})
      : _drawCard = drawCard,
        _getShuffledDeck = getShuffledDeck;

  @override
  Game call() {
    List<Card> deck = _getShuffledDeck();
    final List<Card> player1Cards = List<Card>.empty(growable: true);
    final List<Card> player2Cards = List<Card>.empty(growable: true);

    for (int i = 0; i < _numberOfCardsPerPlayer; i++) {
      Card drawnCard;
      (deck, drawnCard) = _drawCard(deck);
      player1Cards.add(drawnCard);
    }
    for (int i = 0; i < _numberOfCardsPerPlayer; i++) {
      Card drawnCard;
      (deck, drawnCard) = _drawCard(deck);
      player2Cards.add(drawnCard);
    }

    final player1 = Player(cards: player1Cards, id: PlayerId.p1);
    final player2 = Player(cards: player2Cards, id: PlayerId.p2);
    final game = Game(
      player1: player1,
      player2: player2,
      deck: deck,
      phase: initialPhase,
    );

    return game;
  }
}
