import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_poker/src/core/domain/entities/card.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/entities/player.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/draw_card_usecase.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/get_shuffled_deck_usecase.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<DocumentReference<Game>> remoteGameRefProvider = Provider((ref) {
  return ref.read(remoteGameRepositoryProvider).gameReference;
}); // TODO remove this and rely on the RemoteGameDatasourceProvider

Provider<RemoteGameDataRepository> remoteGameRepositoryProvider = Provider(
    (ref) => RemoteGameDataRepository(
        firestore: FirebaseFirestore.instance,
        drawCard: getIt.get(),
        getShuffeledDeck: getIt.get()));

class RemoteGameDataRepository {
  final FirebaseFirestore _firestore;
  final GetShuffeledDeckUsecase _getShuffeledDeck;
  final DrawCardUsecase _drawCard;

  static const String _gameCollectionPath = "games";

  RemoteGameDataRepository(
      {required FirebaseFirestore firestore,
      required GetShuffeledDeckUsecase getShuffeledDeck,
      required DrawCardUsecase drawCard})
      : _firestore = firestore,
        _getShuffeledDeck = getShuffeledDeck,
        _drawCard = drawCard;

  PlayerId? _currentPlayerId;

  PlayerId get currentPlayerId => _assertInitialized(_currentPlayerId);

  DocumentReference<Game>? _gameReference;

  DocumentReference<Game> get gameReference =>
      _assertInitialized(_gameReference);

  Future<void> initialize() async {
    _gameReference = await _getGameReference();
  }

  CollectionReference<Game> get _gamesCollectionRef =>
      _firestore.collection(_gameCollectionPath).withConverter<Game>(
          fromFirestore: (snapshot, _) => Game.fromJson(snapshot.data()!),
          toFirestore: (game, _) => game.toJson());

  Future<DocumentReference<Game>> _getGameReference() async {
    DocumentReference<Game>? gameToJoin = await _findGameToJoin();
    if (gameToJoin != null) {
      return _joinGame(gameToJoin);
    } else {
      return await _createNewGame();
    }
  }

  DocumentReference<Game> _joinGame(DocumentReference<Game> gameToJoin) {
    _currentPlayerId = PlayerId.p2;
    OnlineGameRunning initialPhase =
        OnlineGameRunning({PlayerId.p1: false, PlayerId.p2: false});
    gameToJoin.update({'phase': initialPhase.toJson()});
    return gameToJoin;
  }

  Future<DocumentReference<Game>> _createNewGame() {
    _currentPlayerId = PlayerId.p1;
    List<Card> deck = _getShuffeledDeck();
    List<Card> player1Cards = [];
    List<Card> player2Cards = [];

    for (int i = 0; i < 5; i++) {
      Card drawnCard;
      (deck, drawnCard) = _drawCard(deck);
      player1Cards.add(drawnCard);
    }

    for (int i = 0; i < 5; i++) {
      Card drawnCard;
      (deck, drawnCard) = _drawCard(deck);
      player2Cards.add(drawnCard);
    }

    final Player self = Player(id: currentPlayerId, cards: player1Cards);
    final Player dummy = Player(id: PlayerId.p2, cards: player2Cards);

    final Game game = Game(
      player1: self,
      player2: dummy,
      deck: deck,
      phase: GameWaitingForPlayer(),
    );
    return _gamesCollectionRef.add(game);
  }

  Future<DocumentReference<Game>?> _findGameToJoin() async {
    final gamesAwaitingForPlayersQuery = _gamesCollectionRef
        .where('phase.status', isEqualTo: 'GameWaitingForPlayer');
    final gamesAwaitingForPlayers = await gamesAwaitingForPlayersQuery.get();
    return gamesAwaitingForPlayers.docs.firstOrNull?.reference;
  }

  T _assertInitialized<T>(T? attribute) {
    assert(attribute != null,
        "Make sure that you called and awaited `initialize()` on `RemoteGameDatasource` before accessing any of its members");
    return attribute!;
  }
}
