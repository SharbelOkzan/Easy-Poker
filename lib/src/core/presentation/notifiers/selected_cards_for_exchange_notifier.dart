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
    List<int> updatedSelectedCardsForExchage = List.from(state.selectedCards);
    if (state.selectedCards.contains(cardIndex)) {
      updatedSelectedCardsForExchage.remove(cardIndex);
    } else {
      updatedSelectedCardsForExchage.add(cardIndex);
    }
    state = (
      selectedCards: updatedSelectedCardsForExchage,
      canExchange: state.canExchange
    );
  }

  onCardsExchanged() {
    state = (selectedCards: List.empty(), canExchange: false);
  }

  onNewTurnStarted() {
    state = _initialState;
  }
}
