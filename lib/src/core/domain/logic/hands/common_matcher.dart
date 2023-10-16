import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'hand.dart';

final Matcher pairMatcher = cardsWithSameIndeciesMatcherBuilder(shouldFind: 2);
final Matcher threeOfAKindMatcher = cardsWithSameIndeciesMatcherBuilder(shouldFind: 3);
final Matcher fourOfAKindMatcher = cardsWithSameIndeciesMatcherBuilder(shouldFind: 4);

Matcher cardsWithSameIndeciesMatcherBuilder({required int shouldFind}) =>
    (cards) {
      List<Card> matched = List.empty(growable: true);
      List<Card> remaining = List.from(cards);
      // TODO optimize by reducing num of itterations
      for (Card card in cards) {
        matched.add(card);
        matched.addAll(
            findCardWithSameIndex(card, List.from(cards)..remove(card)));
        if (matched.length == shouldFind) {
          remaining.removeWhere((card) => matched.contains(card));
          break;
        }
        matched = List.empty(growable: true);
        remaining = List.from(cards);
      }
      return (matched: matched, remaining: remaining);
    };

Iterable<Card> findCardWithSameIndex(Card cardToFind, List<Card> cards) {
  List<Card> res =
      cards.where((card) => card.index == cardToFind.index).toList();
  return res;
}
