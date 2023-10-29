import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/entities/game.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/create_new_game_usecase/create_new_online_game_usecase.dart';
import 'package:easy_poker/src/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

FutureProvider<DocumentReference<Game>> remoteGameRefProvider =
    FutureProvider((ref) {
  return ref.watch(remoteGameRepositoryProvider).gameReference;
});

Provider<RemoteGameDataRepository> remoteGameRepositoryProvider = Provider(
    (ref) => RemoteGameDataRepository(
        firestore: FirebaseFirestore.instance,
        createNewOnlineGame: getIt.get()));

class RemoteGameDataRepository {
  static const String _gameCollectionPath = "games";

  final FirebaseFirestore _firestore;
  final CreateNewOnlineGameUsecase _createNewOnlineGame;

  RemoteGameDataRepository(
      {required FirebaseFirestore firestore,
      required CreateNewOnlineGameUsecase createNewOnlineGame})
      : _firestore = firestore,
        _createNewOnlineGame = createNewOnlineGame;

  PlayerId? _currentPlayerId;

  PlayerId get currentPlayerId => _assertInitialized(_currentPlayerId);

  DocumentReference<Game>? _gameReference;

  Future<DocumentReference<Game>> get gameReference async {
    return _gameReference ??= await _getGameReference();
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
    return _gamesCollectionRef.add(_createNewOnlineGame());
  }

  Future<DocumentReference<Game>?> _findGameToJoin() async {
    final gamesAwaitingForPlayersQuery = _gamesCollectionRef
        .where('phase.status', isEqualTo: 'GameWaitingForPlayer');
    final gamesAwaitingForPlayers = await gamesAwaitingForPlayersQuery.get();
    return gamesAwaitingForPlayers.docs.firstOrNull?.reference;
  }

  T _assertInitialized<T>(T? attribute) {
    assert(attribute != null,
        "Make sure that you called and awaited `initialize()` on `RemoteGameDataRepository` before accessing any of its members");
    return attribute!;
  }
}
