// games_repo.dart
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/player/games/models/game_model.dart';
import 'package:aqsa_key_game/features/player/games/games_listing/repository/games_base_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class GamesRepo extends GameBaseRepo {
  final FirebaseFirestore firestore;

  GamesRepo({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<GameModel>>> getCurrentStep({
    required String category,
  }) async {
    try {
      // Reference to the specific category document
      DocumentReference categoryDocRef =
          firestore.collection('categories').doc(category);

      // Fetch the category document
      DocumentSnapshot categorySnapshot = await categoryDocRef.get();

      if (!categorySnapshot.exists) {
        return const Left(NetworkExceptions.notFound('الفئة غير موجودة'));
      }

      // Extract data from the category document
      Map<String, dynamic>? categoryData =
          categorySnapshot.data() as Map<String, dynamic>?;

      if (categoryData == null) {
        return const Left(NetworkExceptions.unexpectedError());
      }

      // Access the 'games' array within the category document
      List<dynamic>? gamesData = categoryData['games'] as List<dynamic>?;

      if (gamesData == null || gamesData.isEmpty) {
        return const Left(
            NetworkExceptions.notFound('لا توجد ألعاب في هذه الفئة'));
      }

      // Initialize an empty list to hold GameModel instances
      List<GameModel> games = [];

      // Iterate over each game data in the 'games' array
      for (var game in gamesData) {
        if (game is Map<String, dynamic>) {
          // Check if the game data contains required fields
          if (game.containsKey('title')) {
            try {
              games.add(GameModel.fromJson(game));
            } catch (e) {
              // Log the error and skip this game
              // Replace with your logging mechanism
              print('Error parsing game data: $game');
              continue;
            }
          } else {
            // Log missing required fields and skip this game
            print('Game data missing "title" field: $game');
            continue;
          }
        } else {
          // Log invalid game data format and skip
          print('Invalid game data format: $game');
          continue;
        }
      }

      if (games.isEmpty) {
        return const Left(
            NetworkExceptions.notFound('لا توجد ألعاب صالحة في هذه الفئة'));
      }

      return Right(games);
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
