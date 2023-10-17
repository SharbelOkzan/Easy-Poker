import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
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
          onPressed: ref.read(gameProvider.notifier).endCurrentGamePhase,
          child: Text("end turn")),
      TextButton(
          onPressed: ref.read(gameProvider.notifier).exchangeCards,
          child: Text("exchange selected")),
      _gameBody(ref),
    ]);
  }

  Widget _gameBody(WidgetRef ref) {
    OfflineGamePhase phase = ref.watch(gameProvider).phase as OfflineGamePhase;
    switch (phase) {
      case FirstPlayerTurnPhase():
      case BetweenTurnsPhase():
      case SecondPlayerTurnPhase():
        return HandWidget(
          selectedCardsForExchangeIndecies:
              ref.watch(gameProvider).selectedCardsForExchangeIndecies,
          cards: ref.watch(gameProvider.notifier).cardsToShow,
          onCardTap: ref.read(gameProvider.notifier).selectCardForExchange,
        );
      case GameEndedPhase():
        return Text(
            "game results ${phase.winner.id} won because ${Hand(cards: phase.winner.cards).handType.name} is stronger than ${Hand(cards: phase.looser.cards).handType.name}");
    }
  }
}
