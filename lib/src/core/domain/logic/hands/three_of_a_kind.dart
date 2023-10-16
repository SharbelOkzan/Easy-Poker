part of 'hand.dart';

class ThreeOfAKind extends Hand {
  @override
  HandType get handType => HandType.threeOfAKind;

  @override
  DrawBreaker drawBreaker = _getCardsIndex;

  @override
  Matcher matcher = threeOfAKindMatcher;

  ThreeOfAKind({required List<Card> cards}) : super._(cards: cards);

  static int _getCardsIndex(List<Card> cards) => cards.first.index.value;
}
