import 'package:easy_poker/src/core/data/repositories/remote_game_repository.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/online_game_controller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/hand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/logic/hands/hand.dart';

class OnlineGamePage extends ConsumerStatefulWidget {
  const OnlineGamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return OnlineGamePageState();
  }
}

class OnlineGamePageState extends ConsumerState<OnlineGamePage> {
  bool _initialized = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    ref.read(remoteGameRefProvider).delete();
    super.deactivate();
  }

  @override
  void initState() {
    ref
        .read(remoteGameRepositoryProvider)
        .initialize()
        .then((_) => setState(() => _initialized = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    return Column(children: [
      TextButton(
          onPressed: ref.read(onlineGameControllerProvider).endCurrentGamePhase,
          child: Text("end turn")),
      TextButton(
          onPressed: () => ref.read(onlineGameControllerProvider).exchangeCards(
              ref.read(selectedCardsForExchangeProvider).selectedCards),
          child: Text("exchange selected")),
      _gameBody(ref),
    ]);
  }

  Widget _gameBody(WidgetRef ref) {
    return switch (ref.watch(remoteGameRefSnapshotsProvider)) {
      AsyncData(:final value) => _getHand(value.data()!),
      AsyncError(:final error) => Text(error.toString()),
      _ => const CircularProgressIndicator(),
    };
  }

  _getHand(Game game) {
    OnlineGamePhase phase = game.phase as OnlineGamePhase;
    switch (phase) {
      case GameWaitingForPlayer():
        return Text("GameWaitingForPlayer");
      case OnlineGameRunning():
        return HandWidget(
          selectedCardsForExchangeIndecies:
              ref.watch(selectedCardsForExchangeProvider).selectedCards,
          cards:
              ref.read(onlineGameControllerProvider).currentActivePlayer!.cards,
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
