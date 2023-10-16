part of 'hand.dart';

class TwoPairs extends Hand {
  @override
  HandType get handType => HandType.twoPairs;
  @override
  DrawBreaker drawBreaker = _getCardsIndciesSum;

  @override
  Matcher matcher = _matchTwoPairs;

  TwoPairs({required List<Card> cards}) : super._(cards: cards);

  // techinacly we should devide by 2 in order to strictly follow the specs,
  // but it doesn't make a difference in practice.
  static int _getCardsIndciesSum(List<Card> cards) => cards.fold<int>(
      0, (previousValue, card) => previousValue + card.index.value);

  // ignore: prefer_function_declarations_over_variables
  static final Matcher _matchTwoPairs = (cards) {
    final ({List<Card> matched, List<Card> remaining}) foundNothing =
        (matched: List.empty(), remaining: List.from(cards));
    final List<Card> firstPair;
    final List<Card> secondPair;
    List<Card> remaining;
    (matched: firstPair, remaining: remaining) = pairMatcher(cards);
    (matched: secondPair, remaining: remaining) = pairMatcher(remaining);
    if (secondPair.isEmpty) {
      return foundNothing;
    }
    return (
      matched: List<Card>.from([...firstPair, ...secondPair]),
      remaining: remaining
    );
  };
}
