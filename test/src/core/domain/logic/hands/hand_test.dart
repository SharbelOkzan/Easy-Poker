import 'package:easy_poker/src/core/domain/logic/hands/hand.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helper.dart';

void main() {
  test("Hand factory creates the correct sybtype", () {
    Hand hand;

    hand = Hand(cards: TestHelper.emptyHand);
    assert(hand is EmptyHand);

    hand = Hand(cards: TestHelper.pairHand);
    assert(hand is Pair);

    hand = Hand(cards: TestHelper.twoPairHand);
    assert(hand is TwoPairs);

    hand = Hand(cards: TestHelper.threeOfAKindHand);
    assert(hand is ThreeOfAKind);

    hand = Hand(cards: TestHelper.fourOfAKindHand);
    assert(hand is FourOfAKind);

    hand = Hand(cards: TestHelper.fullHouseHand);
    assert(hand is FullHouse);

    hand = Hand(cards: TestHelper.pokerHand);
    assert(hand is Poker);
  });
}
