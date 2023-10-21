import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
import 'package:flutter/material.dart';

class CardSuitIconUtil {
  static IconData getIcon(CardSuit suit) {
    return switch (suit) {
      CardSuit.clubs => Icons.garage,
      CardSuit.hearts => Icons.heat_pump_rounded,
      CardSuit.spades => Icons.tab,
      CardSuit.pip => Icons.diamond,
    };
  }
}
