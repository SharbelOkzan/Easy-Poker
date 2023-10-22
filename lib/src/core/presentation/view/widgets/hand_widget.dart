import 'package:flutter/widgets.dart';

import 'package:easy_poker/src/core/presentation/view/widgets/card_widget.dart';
import '../../../domain/entities/card.dart';

class HandWidget extends StatelessWidget {
  const HandWidget(
      {super.key,
      required this.cards,
      required this.onCardTap,
      required this.selectedCardsForExchangeIndices});

  final List<Card>? cards;
  final List<int> selectedCardsForExchangeIndices;
  final void Function(int index) onCardTap;

  @override
  Widget build(BuildContext context) {
    return _HandLayout(
      children: _cardsWidgets,
    );
  }

  List<CardWidget> get _cardsWidgets {
    List<CardWidget> res = List<CardWidget>.empty(growable: true);
    cards!.asMap().forEach((index, card) {
      res.add(CardWidget(
          index: card.index,
          suit: card.suit,
          isSelected: selectedCardsForExchangeIndices.contains(index),
          onTap: () => onCardTap(index)));
    });
    return res;
  }
}

class _HandLayout extends StatelessWidget {
  const _HandLayout({
    Key? key,
    required List<Widget> children,
  })  : _children = children,
        super(key: key);

  final List<Widget> _children;

  List<Widget> get children => _children
      .asMap()
      .map(
        (index, widget) => MapEntry(
          index,
          Transform.translate(
            offset:
                Offset((index - 2) * 40, ((index - 2) * 5).abs().toDouble()),
            child: Transform.rotate(
              angle: (index - 2) / 10,
              child: widget,
            ),
          ),
          // ),
        ),
      )
      .values
      .toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
