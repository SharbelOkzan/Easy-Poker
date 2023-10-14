import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'card.freezed.dart';

@freezed
class Card with _$Card {
  factory Card({required CardSuit suit, required CardIndex index}) = _Card;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
}
