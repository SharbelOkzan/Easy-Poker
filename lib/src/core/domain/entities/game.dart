import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Game {
  final List<Player> players;
  final List<Card> deck;
  final GameStatus status;
  Game({
    required this.players,
    required this.deck,
    required this.status,
  });
}
