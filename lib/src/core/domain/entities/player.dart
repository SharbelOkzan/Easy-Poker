import 'package:freezed_annotation/freezed_annotation.dart';

import 'card.dart';

part 'player.freezed.dart';

@freezed
class Player with _$Player {
  factory Player({
    required List<Card> cards,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
}
