part of 'hand.dart';

class FullHouse extends Hand {
  @override
  DrawBreaker drawBreaker = _getThreeOfAKindCardsIndex;

  @override
  Matcher matcher = _findFullHouse;

  @override
  HandType get handType => HandType.fullHouse;
  // ignore: prefer_function_declarations_over_variables
  static final Matcher _findFullHouse = (List<Card> cards) {
    List<Card> pair, threeOfAKind, temp;

    (matched: pair, remaining: temp) = pairMatcher(cards);
    (matched: threeOfAKind, remaining: _) = threeOfAKindMatcher(temp);
    if (pair.isNotEmpty && threeOfAKind.isNotEmpty) {
      return (
        matched: List<Card>.from([...pair, ...threeOfAKind]),
        remaining: List<Card>.empty()
      );
    }
    return (
      matched: List<Card>.empty(),
      remaining: List<Card>.from(cards),
    );
  };

  FullHouse({required List<Card> cards}) : super._(cards: cards);

  static int _getThreeOfAKindCardsIndex(List<Card> cards) =>
      _findElementWithMostOccurrences<Card>(cards).index.value;

  static T _findElementWithMostOccurrences<T>(List<T> elements) {
    Set<T> uniqueElements = elements.toSet();
    Map<T, int> occurrences = {};

    for (T element in uniqueElements) {
      occurrences[element] = elements.where((e) => e == element).length;
    }

    T elementWithMostOccurrences = occurrences.keys.first;
    int maxOccurrences = occurrences[elementWithMostOccurrences]!;
    occurrences.forEach((key, value) {
      if (value >= maxOccurrences) {
        maxOccurrences = value;
        elementWithMostOccurrences = key;
      }
    });
    return elementWithMostOccurrences;
  }
}
