part of 'hand.dart';

class Poker extends Hand {
  static const List<CardIndex> _requiredCards = [
    CardIndex.ten,
    CardIndex.jack,
    CardIndex.queen,
    CardIndex.king,
    CardIndex.ace,
  ];

  @override
  HandType get handType => HandType.poker;
  @override
  DrawBreaker drawBreaker = (_) => throw UnsupportedError(
      "It's techincally possible, but specs describe it as virtually impossible");

  @override
  Matcher matcher = _pokerMatcher;

  Poker({required List<Card> cards}) : super._(cards: cards);

  // ignore: prefer_function_declarations_over_variables
  static final Matcher _pokerMatcher = (cards) {
    final ({List<Card> matched, List<Card> remaining}) foundNothing =
        (matched: List.empty(), remaining: List.from(cards));

    CardSuit suit = cards.first.suit;
    if (cards.any((card) => card.suit != suit)) {
      return foundNothing;
    }

    List<CardIndex> handIndexies = cards.map((e) => e.index).toList();
    for (CardIndex index in _requiredCards) {
      if (!handIndexies.contains(index)) {
        return foundNothing;
      }
    }

    return (matched: List<Card>.from(cards), remaining: List<Card>.empty());
  };
}
