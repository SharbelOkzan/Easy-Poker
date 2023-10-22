import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/offline_game_cotroller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_helper.dart';

class GameListener extends Mock {
  void call(Game? previous, Game value) => callMockIgnoreParams();
  void callMockIgnoreParams();
}

class SelectedCardsListener extends Mock {
  void call(({List<int> selectedCards, bool canExchange})? previous,
          ({List<int> selectedCards, bool canExchange}) value) =>
      callMockIgnoreParams();
  void callMockIgnoreParams();
}

void main() {
  group('test game presentation logic', () {
    test("selecting/unselecting cards notifies listeners", () {
      configureDependencies();
      final container = ProviderContainer();
      addTearDown(() {
        getIt.reset(dispose: false);
        container.dispose();
      });
      final listener = SelectedCardsListener();

      container.listen<({List<int> selectedCards, bool canExchange})>(
        selectedCardsForExchangeProvider,
        listener.call,
        fireImmediately: true,
      );

      // the listener is called immediately when a game is provided
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);

      // select two cards
      container
          .read(selectedCardsForExchangeProvider.notifier)
          .selectCardForExchange(0);
      container
          .read(selectedCardsForExchangeProvider.notifier)
          .selectCardForExchange(2);
      verify(listener.callMockIgnoreParams()).called(2);
      verifyNoMoreInteractions(listener);
      var listEquality = listEquals(
          container.read(selectedCardsForExchangeProvider).selectedCards,
          const [0, 2]);
      expect(listEquality, true);

      // unselect a card
      container
          .read(selectedCardsForExchangeProvider.notifier)
          .selectCardForExchange(0);
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);
      listEquality = listEquals(
          container.read(selectedCardsForExchangeProvider).selectedCards,
          const [2]);
      expect(listEquality, true);
    });

    test("switching game phases notifies listeners", () {
      configureDependencies();
      final container = ProviderContainer();
      addTearDown(() {
        getIt.reset(dispose: false);
        container.dispose();
      });
      final listener = GameListener();

      container.listen<Game>(
        gameNotifierProvider,
        listener.call,
        fireImmediately: true,
      );

      // verify that first player in-turn and their cards are exposed by `cardsToShow`
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);
      expect(container.read(gameNotifierProvider).phase,
          isA<OfflineGameRunning>());
      expect(
          (container.read(gameNotifierProvider).phase as OfflineGameRunning)
              .currentActivePlayerId,
          equals(PlayerId.p1));
      var listEquality = listEquals(
          container
              .read(offlineGameControllerProvider)
              .currentActivePlayer
              ?.cards,
          container.read(gameNotifierProvider).player1.cards);
      expect(listEquality, true);

      // end phase
      container.read(offlineGameControllerProvider).endCurrentGamePhase();

      // verify that no player's cards are exposed
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);
      expect(container.read(gameNotifierProvider).phase,
          isA<OfflineGameRunning>());
      expect(
          (container.read(gameNotifierProvider).phase as OfflineGameRunning)
              .currentActivePlayerId,
          isNull);
      listEquality = listEquals(
          container
              .read(offlineGameControllerProvider)
              .currentActivePlayer
              ?.cards,
          null);
      expect(listEquality, true);

      // end phase
      container.read(offlineGameControllerProvider).endCurrentGamePhase();

      // verify second player in-turn and their cards are exposed by `cardsToShow`
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);

      expect(container.read(gameNotifierProvider).phase,
          isA<OfflineGameRunning>());
      expect(
          (container.read(gameNotifierProvider).phase as OfflineGameRunning)
              .currentActivePlayerId,
          equals(PlayerId.p2));
      listEquality = listEquals(
          container
              .read(offlineGameControllerProvider)
              .currentActivePlayer
              ?.cards,
          container.read(gameNotifierProvider).player2.cards);
      expect(listEquality, true);

      // end phase
      container.read(offlineGameControllerProvider).endCurrentGamePhase();

      // verify that the game has ended
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);
      expect(container.read(gameNotifierProvider).phase, isA<GameEndedPhase>());
    });

    test("full house beats pair", () {
      configureDependencies();
      final container = ProviderContainer();
      addTearDown(() {
        getIt.reset(dispose: false);
        container.dispose();
      });
      final listener = GameListener();

      Player player1 = Player(id: PlayerId.p1, cards: TestHelper.fullHouseHand);
      Player player2 = Player(id: PlayerId.p2, cards: TestHelper.pairHand);

      Game game = Game(
        deck: [],
        player1: player1,
        player2: player2,
        phase: OfflineGameRunning(currentActivePlayerId: PlayerId.p2),
      );
      container.read(gameNotifierProvider.notifier).state = game;

      // start listening after setting up the predefined game
      container.listen<Game>(
        gameNotifierProvider,
        listener.call,
        fireImmediately: true,
      );
      verify(listener.callMockIgnoreParams()).called(1);
      verifyNoMoreInteractions(listener);

      container.read(offlineGameControllerProvider).endCurrentGamePhase();

      expect(container.read(gameNotifierProvider).phase, isA<GameEndedPhase>());
      expect(
          (container.read(gameNotifierProvider).phase as GameEndedPhase).winner,
          equals(player1));
    });
  });
}
