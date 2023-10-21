import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/logic/hands/hand.dart';
import 'package:flutter/material.dart';

// TODO handle draw case
class GameResultsWidget extends StatelessWidget {
  const GameResultsWidget({super.key, required this.phase});
  final GameEndedPhase phase;

  String get _winner =>
      phase.winner.id == PlayerId.p1 ? 'Player 1' : 'Player 2';

  String get _winnerHand => Hand(cards: phase.winner.cards).handType.name;
  String get _looserHand => Hand(cards: phase.looser.cards).handType.name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$_winner won \n because $_winnerHand is stronger than $_looserHand",
        style: const TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
