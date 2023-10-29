import 'package:easy_poker/src/core/domain/entities/enums/game_phase.dart';
import 'package:easy_poker/src/core/domain/entities/enums/player_id.dart';
import 'package:easy_poker/src/core/domain/logic/usecases/create_new_game_usecase/create_new_game_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateNewOfflineGameUsecase extends CreateNewGameUseCase {
  CreateNewOfflineGameUsecase(
      {required super.drawCard, required super.getShuffledDeck});

  @override
  GamePhase get initialPhase =>
      OfflineGameRunning(currentActivePlayerId: PlayerId.p1);
}
