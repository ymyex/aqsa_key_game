import 'package:aqsa_key_game/features/player/games/models/game_model.dart';

abstract class GamesStates {}

class GamesInitialState extends GamesStates {}

class GamesLoadingState extends GamesStates {}

class GamesLoadedState extends GamesStates {
  final List<GameModel> games;
  GamesLoadedState(this.games);
}

class GameErrorState extends GamesStates {
  final String message;
  GameErrorState(this.message);
}
