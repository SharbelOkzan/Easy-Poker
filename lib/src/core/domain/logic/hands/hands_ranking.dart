import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/logic/hands/hand.dart';

enum HandType {
  emptyHand(EmptyHand.new),
  pair(Pair.new),
  twoPairs(TwoPairs.new),
  threeOfAKind(ThreeOfAKind.new),
  fourOfAKind(FourOfAKind.new),
  fullHouse(FullHouse.new),
  poker(Poker.new);

  final Hand Function({required List<Card> cards}) handBuilder;

  const HandType(this.handBuilder);
}
