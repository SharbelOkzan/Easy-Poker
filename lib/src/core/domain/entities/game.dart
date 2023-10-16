import 'package:freezed_annotation/freezed_annotation.dart';

import 'card.dart';
import 'enums/game_status.dart';
import 'player.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class Game with _$Game {
  factory Game({
    required Player player1,
    required Player player2,
    required List<Card> deck,
    required GameStatus status,
    required List<int> selectedCardsForExchangeIndecies,
  }) = _Game;

  Game._();

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
