part of 'hand.dart';

class Pair extends Hand {
  @override
  HandType get handType => HandType.pair;
  @override
  DrawBreaker drawBreaker = _getCardsIndex;

  @override
  Matcher matcher = pairMatcher;

  Pair({required List<Card> cards}) : super._(cards: cards);

  static int _getCardsIndex(List<Card> cards) => cards.first.index.value;
}
