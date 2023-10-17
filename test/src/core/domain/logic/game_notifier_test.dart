import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';

class Listener extends Mock {
  void call(Game? previous, Game value) => callMockIgnoreParams();
  void callMockIgnoreParams();
}

void main() {
  test("selecting/unselecting cards notifies listerns", () {
    configureDependencies();
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener();

    container.listen<Game>(
      gameProvider,
      listener.call,
      fireImmediately: true,
    );

    // the listener is called immediately when a game is provided
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);

    // select two cards
    container.read(gameProvider.notifier).selectCardForExchange(0);
    container.read(gameProvider.notifier).selectCardForExchange(2);
    verify(listener.callMockIgnoreParams()).called(2);
    verifyNoMoreInteractions(listener);
    var listEqulity = listEquals(
        container.read(gameProvider).selectedCardsForExchangeIndecies,
        const [0, 2]);
    expect(listEqulity, true);

    // unselect a card
    container.read(gameProvider.notifier).selectCardForExchange(0);
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);
    listEqulity = listEquals(
        container.read(gameProvider).selectedCardsForExchangeIndecies,
        const [2]);
    expect(listEqulity, true);
  });

  test("switching game phases notifies listerns", () {
    configureDependencies();
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener();

    container.listen<Game>(
      gameProvider,
      listener.call,
      fireImmediately: true,
    );

    // verify that first player in-turn and their cards are exposed by `cardsToShow`
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);
    expect(container.read(gameProvider).phase, isA<FirstPlayerTurnPhase>());
    var listEquality = listEquals(
        container.read(gameProvider.notifier).cardsToShow,
        container.read(gameProvider).player1.cards);
    expect(listEquality, true);

    // end phase
    container.read(gameProvider.notifier).endCurrentGamePhase();

    // verify that no player's cards are exposed
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);
    expect(container.read(gameProvider).phase, isA<BetweenTurnsPhase>());
    listEquality =
        listEquals(container.read(gameProvider.notifier).cardsToShow, null);
    expect(listEquality, true);

    // end phase
    container.read(gameProvider.notifier).endCurrentGamePhase();

    // verify second player in-turn and their cards are exposed by `cardsToShow`
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);
    expect(container.read(gameProvider).phase, isA<SecondPlayerTurnPhase>());
    listEquality = listEquals(container.read(gameProvider.notifier).cardsToShow,
        container.read(gameProvider).player2.cards);
    expect(listEquality, true);

    // end phase
    container.read(gameProvider.notifier).endCurrentGamePhase();

    // verify that the game has ended
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);
    expect(container.read(gameProvider).phase, isA<GameEndedPhase>());
  });

  test("full house beats pair", () {
    configureDependencies();
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener();

    Player player1 = Player(id: 1, cards: TestHelper.fullHouseHand);
    Player player2 = Player(id: 2, cards: TestHelper.pairHand);

    Game game = Game(
      deck: [],
      player1: player1,
      player2: player2,
      selectedCardsForExchangeIndecies: [],
      phase: SecondPlayerTurnPhase(),
    );
    container.read(gameProvider.notifier).state = game;

    // start listening after setting up the predefined game
    container.listen<Game>(
      gameProvider,
      listener.call,
      fireImmediately: true,
    );
    verify(listener.callMockIgnoreParams()).called(1);
    verifyNoMoreInteractions(listener);

    container.read(gameProvider.notifier).endCurrentGamePhase();

    expect(container.read(gameProvider).phase, isA<GameEndedPhase>());
    expect((container.read(gameProvider).phase as GameEndedPhase).winner,
        equals(player1));
  });
}
