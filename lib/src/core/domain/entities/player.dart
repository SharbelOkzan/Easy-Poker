import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'card.dart';

part 'player.freezed.dart';
part 'player.g.dart';

@freezed
class Player with _$Player {
  factory Player({
    required PlayerId id,
    required List<Card> cards,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
