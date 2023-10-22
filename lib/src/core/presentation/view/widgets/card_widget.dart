import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
import 'package:easy_poker/src/core/presentation/view/utils/card_suit_icon_util.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.index,
    required this.suit,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final CardIndex index;
  final CardSuit suit;
  final bool isSelected;
  final VoidCallback onTap;

  Color get _borderColor => isSelected ? Colors.blue : Colors.black;
  double get _borderWidth => isSelected ? 3 : 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: _borderColor,
                width: _borderWidth,
                strokeAlign: BorderSide.strokeAlignOutside),
          ),
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CardTitle(
                index: index,
                suit: suit,
                placement: _CardTitlePlacement.top,
              ),
              Align(
                alignment: Alignment.center,
                child: _CardContent(
                  index: index,
                  suit: suit,
                ),
              ),
              _CardTitle(
                index: index,
                suit: suit,
                placement: _CardTitlePlacement.bottom,
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(
      {super.key,
      required this.index,
      required this.suit,
      required this.placement});

  final CardIndex index;
  final CardSuit suit;
  final _CardTitlePlacement placement;
  MainAxisAlignment get _mainAxisAlignment => switch (placement) {
        _CardTitlePlacement.top => MainAxisAlignment.start,
        _CardTitlePlacement.bottom => MainAxisAlignment.end,
      };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      children: [
        Text(index.displayName),
        const SizedBox(width: 4),
        Icon(CardSuitIconUtil.getIcon(suit))
      ],
    );
  }
}

enum _CardTitlePlacement {
  top,
  bottom,
}

class _CardContent extends StatelessWidget {
  const _CardContent({super.key, required this.index, required this.suit});

  final CardIndex index;
  final CardSuit suit;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        for (int i = 0; i < index.value; i++)
          Icon(CardSuitIconUtil.getIcon(suit))
      ],
    );
  }
}
