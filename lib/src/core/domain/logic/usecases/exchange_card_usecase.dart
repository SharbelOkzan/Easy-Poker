import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:injectable/injectable.dart';

import 'draw_card_usecase.dart';
import 'usecase.dart';

@injectable
class ExchangeCardUsecase extends UseCase<
    (List<Card> upatedDeck, List<Card> upatedHand),
    ({List<Card> deck, List<Card> hand, int cardToExchangeIndex})> {
  final DrawCardUsecase _drawCard;

  ExchangeCardUsecase(this._drawCard);

  @override
  (List<Card>, List<Card>) call(
      ({int cardToExchangeIndex, List<Card> deck, List<Card> hand}) param) {
    List<Card> updatedDeck, updatedHand;
    Card drawnCard;
    (updatedDeck, drawnCard) = _drawCard(param.deck);
    updatedHand = [...param.hand]..replaceRange(
        param.cardToExchangeIndex, param.cardToExchangeIndex + 1, [drawnCard]);
    return (updatedDeck, updatedHand);
  }
}
