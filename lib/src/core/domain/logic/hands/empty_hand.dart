part of 'hand.dart';

class EmptyHand extends Hand {
  @override
  DrawBreaker drawBreaker = _getCardsIndex;

  @override
  Matcher matcher = _matchAll;

  EmptyHand({required List<Card> cards}) : super._(cards: cards);

  static int _getCardsIndex(List<Card> cards) => cards.first.index.value;

  // Though this matching all may look counterintuitive,
  // it's actually the correct behaviour
  // ignore: prefer_function_declarations_over_variables
  static final Matcher _matchAll =
      (cards) => (matched: List.from(cards), remaining: List<Card>.empty());

  @override
  HandType get handType => HandType.emptyHand;
}
