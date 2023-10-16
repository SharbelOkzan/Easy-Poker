part of 'hand.dart';

class FourOfAKind extends Hand {
  @override
  @protected
  DrawBreaker drawBreaker = _getCardsIndex;

  @override
  @protected
  Matcher matcher = fourOfAKindMatcher;

  FourOfAKind({required List<Card> cards}) : super._(cards: cards);

  static int _getCardsIndex(List<Card> cards) => cards.first.index.value;

  @override
  HandType get handType => HandType.fourOfAKind;
}
