import 'package:easy_poker/src/core/constants/game_constants.dart';
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
    required List<CardWidget> children,
  })  : _children = children,
        super(key: key);

  final List<CardWidget> _children;

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

  List<Widget> get children {
    return _children
        .asMap()
        .map(
          (index, widget) => MapEntry(
            index,
            Transform.translate(
              offset: _getCardOffset(index, widget.isSelected),
              child: Transform.rotate(
                angle: _getAngle(index),
                child: widget,
              ),
            ),
          ),
        )
        .values
        .toList();
  }

  Offset _getCardOffset(int index, bool isSelected) {
    const double kSelectedCardYOffset = 20;
    const double kCardXOffsetFactor = 60;
    const double kCardYOffsetFactor = 1;

    const lastIndex = GameConstants.cardsPerPlayer - 1;

    final int cardsToTheLeft = lastIndex - index;
    final int cardsToTheRight = index;
    final int distanceFromCenter = cardsToTheRight - cardsToTheLeft;

    const double cardXOffsetFactor =
        kCardXOffsetFactor / lastIndex; // more cards -> less X offset
    final double cardXOffset = distanceFromCenter * cardXOffsetFactor;

    const double cardYOffsetFactor =
        kCardYOffsetFactor * lastIndex; // more cards -> more Y offset
    final double cardYOffset = (distanceFromCenter * cardYOffsetFactor).abs();

    return Offset(cardXOffset,
        isSelected ? cardYOffset - kSelectedCardYOffset : cardYOffset);
  }

  double _getAngle(int index) {
    const double rotationFactor = 10;

    const lastIndex = GameConstants.cardsPerPlayer - 1;

    final int cardsToTheLeft = lastIndex - index;
    final int cardsToTheRight = index;
    final int distanceFromCenter = cardsToTheRight - cardsToTheLeft;

    return distanceFromCenter / rotationFactor;
  }
}
