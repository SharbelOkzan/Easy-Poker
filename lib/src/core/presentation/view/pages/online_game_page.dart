import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_poker/src/core/data/repositories/remote_game_repository.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/logic/controllers/online_game_controller.dart';
import 'package:easy_poker/src/core/presentation/notifiers/selected_cards_for_exchange_notifier.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/game_controls_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/game_results_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/hand_widget.dart';
import 'package:easy_poker/src/core/presentation/view/widgets/waiting_for_players_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  void deactivate() {
    ref.read(remoteGameRefProvider).value?.delete();
    super.deactivate();
  }

  @override
  void didChangeDependencies() {
    ref.invalidate(remoteGameRepositoryProvider);
    ref.invalidate(remoteGameRefProvider);
    ref.invalidate(remoteGameRefSnapshotsProvider);
    ref.invalidate(selectedCardsForExchangeProvider);
    ref
        .read(remoteGameRepositoryProvider)
        .gameReference
        .then((_) => setState(() => _initialized = true));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const CircularProgressIndicator();
    }
    return Scaffold(body: _mapStreamToWidget(ref));
  }

  Widget _mapStreamToWidget(WidgetRef ref) {
    return switch (ref.watch(remoteGameRefSnapshotsProvider)) {
      AsyncData<DocumentSnapshot<Game>>(:final value) => value.exists
          ? _getGameBody(value.data()!)
          : const CircularProgressIndicator(),
      AsyncError(:final error) =>
        Text("Something went wrong, please try again \n $error"),
      _ => const CircularProgressIndicator(),
    };
  }

  Widget _getGameBody(Game game) {
    return Column(
      children: [
        GameControls(game.phase, onlineGameControllerProvider),
        _getHand(game),
      ],
    );
  }

  Widget _getHand(Game game) {
    OnlineGamePhase phase = game.phase as OnlineGamePhase;
    switch (phase) {
      case GameWaitingForPlayer():
        return const WaitingForPlayersWidget();
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
        return GameResultsWidget(phase: phase);
    }
  }
}
