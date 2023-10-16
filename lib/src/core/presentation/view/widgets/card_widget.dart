import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
          color: isSelected ? Colors.amber : Colors.blue,
          child: Text(index.displayName + 'of' + suit.name),
        ),
      ),
    );
  }
}
