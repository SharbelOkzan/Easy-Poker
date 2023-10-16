import 'package:easy_poker/src/core/domain/entities/enums/game_status.dart';
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
          onPressed: ref.read(gameProvider.notifier).endPlayerTurn,
          child: Text("end turn")),
      TextButton(
          onPressed: ref.read(gameProvider.notifier).exchangeCards,
          child: Text("exchange selected")),
      _gameBody(ref),
    ]);
  }

  Widget _gameBody(WidgetRef ref) {
    GameStatus status = ref.watch(gameProvider).status;
    switch (status) {
      case GameRunning():
        return HandWidget(
          selectedCardsForExchangeIndecies:
              ref.watch(gameProvider).selectedCardsForExchangeIndecies,
          cards: ref.watch(gameProvider.notifier).cardsToShow,
          onCardTap: ref.read(gameProvider.notifier).selectCardForExchange,
        );
      case GameEnded():
        return Text(
            "game results ${status.winner.id} won because ${Hand(cards: status.winner.cards).handType.name} is stronger than ${Hand(cards: status.looser.cards).handType.name}");
    }
  }
}
