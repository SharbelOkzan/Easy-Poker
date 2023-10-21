import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/offline_game_cotroller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/game_notifier.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/game_results_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(gameNotifierProvider, (prev, next) {
      final hasNewTurnStarted = prev != null &&
          prev.phase is OfflineGameRunning &&
          (prev.phase as OfflineGameRunning).currentActivePlayerId == null &&
          next.phase is OfflineGameRunning &&
          (next.phase as OfflineGameRunning).currentActivePlayerId != null;

      if (hasNewTurnStarted) {
        ref.read(selectedCardsForExchangeProvider.notifier).onNewTurnStarted();
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _GameButtons(
                ref: ref,
              ),
              _gameBody(ref),
            ]),
      ),
    );
  }

  Widget _gameBody(WidgetRef ref) {
    OfflineGamePhase phase =
        ref.watch(gameNotifierProvider).phase as OfflineGamePhase;
    switch (phase) {
      case OfflineGameRunning():
        return HandWidget(
          selectedCardsForExchangeIndecies:
              ref.watch(selectedCardsForExchangeProvider).selectedCards,
          cards: ref
              .watch(offlineGameControllerProvider)
              .currentActivePlayer
              ?.cards,
          onCardTap: ref
              .read(selectedCardsForExchangeProvider.notifier)
              .selectCardForExchange,
        );
      case GameEndedPhase():
        return GameResultsWidget(phase: phase);
    }
  }
}

class _GameButtons extends StatelessWidget {
  final WidgetRef ref;
  const _GameButtons({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (ref.watch(gameNotifierProvider).phase is! GameEndedPhase)
            TextButton(
                onPressed:
                    ref.read(offlineGameControllerProvider).endCurrentGamePhase,
                child: const Text("Done")),
          if (ref.watch(selectedCardsForExchangeProvider).canExchange)
            TextButton(
                onPressed: _onExchangeCardsPressed,
                child: const Text("Exchange selected")),
        ],
      ),
    );
  }

  void _onExchangeCardsPressed() {
    ref.read(offlineGameControllerProvider).exchangeCards(
        ref.read(selectedCardsForExchangeProvider).selectedCards);
    ref.read(selectedCardsForExchangeProvider.notifier).onCardsExchanged();
  }
}
