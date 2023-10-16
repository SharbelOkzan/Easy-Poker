import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:injectable/injectable.dart';

import 'usecase.dart';

@injectable
class DrawCardUsecase
    extends UseCase<(List<Card> deck, Card drawnCard), List<Card>> {
  @override
  (List<Card>, Card) call(List<Card> param) {
    Card drawnCard = param.first;
    List<Card> updatedDeck = [...param]..remove(drawnCard);
    return (updatedDeck, drawnCard);
  }
}
