import 'package:easy_poker/src/core/domain/logic/hands/hands_ranking.dart';

class GameConstants {
  static const List<HandType> handsRanking = [
    HandType.emptyHand,
    HandType.pair,
    HandType.twoPairs,
    HandType.threeOfAKind,
    HandType.fourOfAKind,
    HandType.fullHouse,
    HandType.poker,
  ];
}
