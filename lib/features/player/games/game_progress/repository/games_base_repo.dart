import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/features/player/games/models/game_model.dart';
import 'package:dartz/dartz.dart';

abstract class GameBaseRepo {
  /// Fetches the list of games.
  Future<Either<Failure, List<GameModel>>> getGames({required String category});
}
