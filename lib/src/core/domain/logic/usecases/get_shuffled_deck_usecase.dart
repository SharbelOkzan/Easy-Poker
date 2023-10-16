import 'package:easy_poker/src/core/domain/entities/enums/card_index.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/usecase.dart';
import 'package:injectable/injectable.dart';

import '../../entities/card.dart';
import '../../entities/enums/card_suit.dart';

@injectable
class GetShuffeledDeckUsecase extends NoParamsUseCase<List<Card>> {
  @override
  List<Card> call() {
    List<Card> allCards = List<Card>.empty(growable: true);
    for (CardIndex index in CardIndex.values) {
      for (CardSuit suit in CardSuit.values) {
        allCards.add(Card(suit: suit, index: index));
      }
    }
    allCards.shuffle();
    return allCards;
  }
}
