import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/game_controller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameControls extends ConsumerWidget {
  final GamePhase phase;
  final ProviderListenable<GameController> controller;
  const GameControls(
    this.phase,
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (phase is! GameEndedPhase)
            TextButton(
                onPressed: ref.read(controller).endCurrentGamePhase,
                child: const Text("Done")),
          if (ref.watch(selectedCardsForExchangeProvider).canExchange)
            TextButton(
                onPressed: () => _onExchangeCardsPressed(ref),
                child: const Text("Exchange selected")),
        ],
      ),
    );
  }

  void _onExchangeCardsPressed(WidgetRef ref) {
    ref.read(controller).exchangeCards(
        ref.read(selectedCardsForExchangeProvider).selectedCards);
    ref.read(selectedCardsForExchangeProvider.notifier).onCardsExchanged();
  }
}
