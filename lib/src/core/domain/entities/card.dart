import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';

class Card {
  final CardSuit suit;
  final CardIndex index;

  Card({required this.suit, required this.index});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Card && other.suit == suit && other.index == index;
  }

  @override
  int get hashCode => suit.hashCode ^ index.hashCode;
}
