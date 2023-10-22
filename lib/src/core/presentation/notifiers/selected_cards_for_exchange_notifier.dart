import 'package:flutter_riverpod/flutter_riverpod.dart';

NotifierProvider<SelectedCardsNotifier,
        ({List<int> selectedCards, bool canExchange})>
    selectedCardsForExchangeProvider = NotifierProvider<
        SelectedCardsNotifier,
        ({
          List<int> selectedCards,
          bool canExchange
        })>(SelectedCardsNotifier.new);

class SelectedCardsNotifier
    extends Notifier<({List<int> selectedCards, bool canExchange})> {
  final _initialState = (selectedCards: List<int>.empty(), canExchange: true);

  @override
  ({List<int> selectedCards, bool canExchange}) build() {
    return _initialState;
  }

  void selectCardForExchange(int cardIndex) {
    List<int> updatedSelectedCardsForExchange = List.from(state.selectedCards);
    if (state.selectedCards.contains(cardIndex)) {
      updatedSelectedCardsForExchange.remove(cardIndex);
    } else {
      updatedSelectedCardsForExchange.add(cardIndex);
    }
    state = (
      selectedCards: updatedSelectedCardsForExchange,
      canExchange: state.canExchange
    );
  }

  onCardsExchanged() {
    state = (selectedCards: List.empty(), canExchange: false);
  }
}
