import 'package:flutter_riverpod/flutter_riverpod.dart';

NotifierProvider<SelectedCardsNotifier, List<int>>
    selectedCardsForExchangeProvider =
    NotifierProvider<SelectedCardsNotifier, List<int>>(
        SelectedCardsNotifier.new);

class SelectedCardsNotifier extends Notifier<List<int>> {
  @override
  List<int> build() {
    return List<int>.empty();
  }

  void selectCardForExchange(int cardIndex) {
    List<int> updatedSelectedCardsForExchage = List.from(state);
    if (state.contains(cardIndex)) {
      updatedSelectedCardsForExchage.remove(cardIndex);
    } else {
      updatedSelectedCardsForExchage.add(cardIndex);
    }
    state = updatedSelectedCardsForExchage;
  }

  clearSelectedCards() {
    state = List<int>.empty();
  }
}
