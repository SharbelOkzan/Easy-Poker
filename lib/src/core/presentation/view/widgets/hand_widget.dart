import 'package:easy_poker/src/core/presentation/view/widgets/card_widget.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/entities/card.dart';

class HandWidget extends StatelessWidget {
  const HandWidget(
      {super.key,
      required this.cards,
      required this.onCardTap,
      required this.selectedCardsForExchangeIndecies});

  final List<Card>? cards;
  final List<int> selectedCardsForExchangeIndecies;
  final void Function(int index) onCardTap;

  @override
  Widget build(BuildContext context) {
    return cards == null
        ? Text("closed hand")
        : Row(
            children: _cardsWidgets,
          );
  }

  List<CardWidget> get _cardsWidgets {
    List<CardWidget> res = List<CardWidget>.empty(growable: true);
    cards!.asMap().forEach((index, card) {
      res.add(CardWidget(
          index: card.index,
          suit: card.suit,
          isSelected: selectedCardsForExchangeIndecies.contains(index),
          onTap: () => onCardTap(index)));
    });
    return res;
  }
}
