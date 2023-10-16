import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';

class TestHelper {
  static Card aceOfSpades = Card(index: CardIndex.ace, suit: CardSuit.spades);
  static Card kingOfSpades = Card(index: CardIndex.king, suit: CardSuit.spades);
  static Card queenOfSpades =
      Card(index: CardIndex.queen, suit: CardSuit.spades);
  static Card jackOfSpades = Card(index: CardIndex.jack, suit: CardSuit.spades);
  static Card jackOfHearts = Card(index: CardIndex.jack, suit: CardSuit.hearts);
  static Card tenOfSpades = Card(index: CardIndex.ten, suit: CardSuit.spades);
  static Card tenOfHearts = Card(index: CardIndex.ten, suit: CardSuit.hearts);
  static Card tenOfPip = Card(index: CardIndex.ten, suit: CardSuit.pip);
  static Card tenOfClubs = Card(index: CardIndex.ten, suit: CardSuit.clubs);
  static Card twoOfClubs = Card(index: CardIndex.two, suit: CardSuit.clubs);
  static Card threeOfClubs = Card(index: CardIndex.three, suit: CardSuit.clubs);
  static Card fourOfClubs = Card(index: CardIndex.four, suit: CardSuit.clubs);

  static List<Card> emptyHand = [
    tenOfSpades,
    jackOfHearts,
    twoOfClubs,
    threeOfClubs,
    fourOfClubs
  ];
  static List<Card> pairHand = [
    tenOfSpades,
    tenOfHearts,
    twoOfClubs,
    threeOfClubs,
    fourOfClubs
  ];
  static List<Card> twoPairHand = [
    tenOfSpades,
    tenOfHearts,
    jackOfSpades,
    jackOfHearts,
    fourOfClubs
  ];
  static List<Card> threeOfAKindHand = [
    tenOfSpades,
    tenOfHearts,
    tenOfPip,
    threeOfClubs,
    fourOfClubs
  ];
  static List<Card> fourOfAKindHand = [
    tenOfSpades,
    tenOfHearts,
    tenOfPip,
    tenOfClubs,
    fourOfClubs
  ];
  static List<Card> fullHouseHand = [
    tenOfSpades,
    tenOfHearts,
    tenOfPip,
    jackOfHearts,
    jackOfSpades
  ];
  static List<Card> pokerHand = [
    tenOfSpades,
    jackOfSpades,
    queenOfSpades,
    kingOfSpades,
    aceOfSpades
  ];
}
