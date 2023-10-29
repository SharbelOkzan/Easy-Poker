import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';

class CardSuitIconUtil {
  static String getIcon(CardSuit suit) {
    return switch (suit) {
      CardSuit.clubs => '♣',
      CardSuit.hearts => '♥',
      CardSuit.spades => '♠',
      CardSuit.pip => '♦',
    };
  }
}
