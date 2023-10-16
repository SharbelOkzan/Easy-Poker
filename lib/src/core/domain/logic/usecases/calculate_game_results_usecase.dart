import 'package:easy_poker/src/core/constants/game_constants.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/hands/hand.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalculateGameResultsUsecase
    extends UseCase<({Player winner, Player looser}), (Player, Player)> {
  @override
  ({Player winner, Player looser}) call((Player, Player) param) {
    int player1HandRand = GameConstants.handsRanking.indexWhere(
        (handType) => Hand(cards: param.$1.cards).handType == handType);
    int player2HandRand = GameConstants.handsRanking.indexWhere(
        (handType) => Hand(cards: param.$2.cards).handType == handType);

    if (player1HandRand > player2HandRand) {
      return (winner: param.$1, looser: param.$2);
    } else if (player1HandRand < player2HandRand) {
      return (winner: param.$2, looser: param.$1);
    } else {
      return _breakDraw(param.$1, param.$2);
    }
  }

  ({Player winner, Player looser}) _breakDraw(Player p1, Player p2) {
    int player1HandDealBreaker = Hand(cards: p1.cards).drawBreak;
    int player2HandDealBreaker = Hand(cards: p2.cards).drawBreak;

    if (player1HandDealBreaker > player2HandDealBreaker) {
      return (winner: p1, looser: p2);
    } else if (player1HandDealBreaker < player2HandDealBreaker) {
      return (winner: p2, looser: p1);
    } else {
      throw UnimplementedError(
          "Current game rules doesn't involve equal draw. \n Check if new Hand(s) has been added, or additional cards has been added to the standard deck.");
    }
  }
}
