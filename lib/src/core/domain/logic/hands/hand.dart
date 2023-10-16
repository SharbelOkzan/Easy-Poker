import 'package:easy_poker/src/core/constants/game_constants.dart';
import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/entities/enums/card_suit.dart';
import 'package:easy_poker/src/core/domain/logic/hands/common_matcher.dart';
import 'package:easy_poker/src/core/domain/logic/hands/hands_ranking.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'empty_hand.dart';
part 'pair.dart';
part 'two_pairs.dart';
part 'three_of_a_kind.dart';
part 'full_house.dart';
part 'four_of_a_kind.dart';
part 'poker.dart';

sealed class Hand {
  @protected
  abstract Matcher matcher;
  @protected
  abstract DrawBreaker drawBreaker;
  final List<Card> _cards;

  Hand._({
    required List<Card> cards,
  }) : _cards = cards;

  bool get isMatch {
    return matcher(_cards).matched.isNotEmpty;
  }

  int get drawBreak => drawBreaker(matcher(_cards).matched);

  HandType get handType;

  factory Hand({required List<Card> cards}) {
    var itr = GameConstants.handsRanking.reversed.iterator;
    itr.moveNext();
    Hand hand = itr.current.handBuilder.call(cards: cards);
    while (!hand.isMatch) {
      itr.moveNext();
      hand = itr.current.handBuilder.call(cards: cards);
    }
    return hand;
  }
}

typedef Matcher = ({List<Card> matched, List<Card> remaining}) Function(
    List<Card> cards);

typedef DrawBreaker = int Function(List<Card> cards);
