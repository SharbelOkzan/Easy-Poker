import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/offline_game_cotroller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/offline_game_notifier.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/game_controls_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/game_results_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfflineGamePage extends ConsumerStatefulWidget {
  const OfflineGamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return OfflineGamePageState();
  }
}

class OfflineGamePageState extends ConsumerState<OfflineGamePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref.invalidate(gameNotifierProvider);
    ref.invalidate(selectedCardsForExchangeProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameNotifierProvider, (prev, next) {
      final hasNewTurnStarted = prev != null &&
          prev.phase is OfflineGameRunning &&
          (prev.phase as OfflineGameRunning).currentActivePlayerId == null &&
          next.phase is OfflineGameRunning &&
          (next.phase as OfflineGameRunning).currentActivePlayerId != null;

      if (hasNewTurnStarted) {
        ref.invalidate(selectedCardsForExchangeProvider);
      }
    });
    return Scaffold(
      body: _getGameBodyAndControls(ref),
    );
  }

  _getGameBodyAndControls(WidgetRef ref) {
    return Center(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GameControls(
                ref.watch(gameNotifierProvider).phase as OfflineGamePhase,
                offlineGameControllerProvider),
            _getGameBody(ref),
          ]),
    );
  }

  Widget _getGameBody(WidgetRef ref) {
    OfflineGamePhase phase =
        ref.watch(gameNotifierProvider).phase as OfflineGamePhase;
    switch (phase) {
      case OfflineGameRunning():
        bool hasActivePlayer =
            ref.watch(offlineGameControllerProvider).currentActivePlayer !=
                null;

        return (hasActivePlayer)
            ? _getHand(ref)
            : const _BetweenTurnsInstructionsWidget();
      case GameEndedPhase():
        return Expanded(child: GameResultsWidget(phase: phase));
    }
  }

  HandWidget _getHand(WidgetRef ref) {
    return HandWidget(
      selectedCardsForExchangeIndices:
          ref.watch(selectedCardsForExchangeProvider).selectedCards,
      cards:
          ref.watch(offlineGameControllerProvider).currentActivePlayer!.cards,
      onCardTap: ref
          .read(selectedCardsForExchangeProvider.notifier)
          .selectCardForExchange,
    );
  }
}

class _BetweenTurnsInstructionsWidget extends StatelessWidget {
  const _BetweenTurnsInstructionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text(
          "Pass the phone to the next player",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
