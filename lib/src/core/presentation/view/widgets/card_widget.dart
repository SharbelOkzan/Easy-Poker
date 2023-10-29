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

  static const _cardWidth = 100.0;
  static const _cardHeight = 200.0;

  double get _borderWidth => isSelected ? 3 : 1;
  double get _shadowBlurRadius => isSelected ? 4 : 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        width: _cardWidth,
        height: _cardHeight,
        decoration: _getCardDecoration(context),
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
    );
  }

  BoxDecoration _getCardDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      boxShadow: [
        BoxShadow(
          color: _getShadowColor(context).withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: _shadowBlurRadius,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: _getShadowColor(context).withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: _shadowBlurRadius,
          offset: const Offset(0, -3),
        )
      ],
      border: Border.all(
          color: _getBorderColor(context),
          width: _borderWidth,
          strokeAlign: BorderSide.strokeAlignOutside),
    );
  }

  Color _getBorderColor(BuildContext context) {
    return isSelected
        ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
        : Theme.of(context).colorScheme.onPrimary;
  }

  Color _getShadowColor(BuildContext context) {
    return isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
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
        Text(
          index.displayName,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(width: 4),
        Text(CardSuitIconUtil.getIcon(suit))
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

  static const _pictures = {
    CardIndex.king: 'K',
    CardIndex.queen: 'Q',
    CardIndex.jack: 'J',
  };
  final CardIndex index;
  final CardSuit suit;

  @override
  Widget build(BuildContext context) {
    if (index == CardIndex.ace) {
      return _fillWithAceIcon(context);
    }
    if (_pictures.containsKey(index)) {
      return _fillWithPicture(context);
    }
    return _fillWithSuitIcon(context);
  }

  Wrap _fillWithSuitIcon(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        for (int i = 0; i < index.value; i++)
          Text(CardSuitIconUtil.getIcon(suit),
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).colorScheme.onSurface))
      ],
    );
  }

  Widget _fillWithPicture(BuildContext context) {
    return Text(
      _pictures[index]!,
      style: TextStyle(
        fontSize: 60,
        color: Theme.of(context).colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _fillWithAceIcon(BuildContext context) {
    return Text(
      CardSuitIconUtil.getIcon(suit),
      style: TextStyle(
        fontSize: 60,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
