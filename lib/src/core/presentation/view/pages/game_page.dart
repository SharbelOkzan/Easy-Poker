import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/offline_game_cotroller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/logic/hands/hand.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(children: [
      TextButton(
          onPressed:
              ref.read(offlineGameControllerProvider).endCurrentGamePhase,
          child: Text("end turn")),
      TextButton(
          onPressed: () => ref
              .read(offlineGameControllerProvider)
              .exchangeCards(ref.read(selectedCardsForExchangeProvider)),
          child: Text("exchange selected")),
      _gameBody(ref),
    ]);
  }

  Widget _gameBody(WidgetRef ref) {
    OfflineGamePhase phase =
        ref.watch(gameNotifierProvider).phase as OfflineGamePhase;
    switch (phase) {
      case OfflineGameRunning():
        return HandWidget(
          selectedCardsForExchangeIndecies:
              ref.watch(selectedCardsForExchangeProvider),
          cards: ref
              .watch(offlineGameControllerProvider)
              .currentActivePlayer
              ?.cards,
          onCardTap: ref
              .read(selectedCardsForExchangeProvider.notifier)
              .selectCardForExchange,
        );
      case GameEndedPhase():
        return Text(
            "game results ${phase.winner.id} won because ${Hand(cards: phase.winner.cards).handType.name} is stronger than ${Hand(cards: phase.looser.cards).handType.name}");
    }
  }
}
