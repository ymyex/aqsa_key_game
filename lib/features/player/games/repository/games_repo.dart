// games_repo.dart
import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/player/games/models/game_model.dart';
import 'package:aqsa_key_game/features/player/games/repository/games_base_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class GamesRepo extends GameBaseRepo {
  final FirebaseFirestore firestore;

  GamesRepo({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<GameModel>>> getGames({
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

  @override
  Future<Either<Failure, List<GameModel>>> markStepCompleted({
    required String category,
    required String gameName,
    required String teamName,
    required String stepIndex,
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

      // Find the index of the game whose 'title' equals gameName
      final gameIndex = gamesData.indexWhere((g) => g['title'] == gameName);
      if (gameIndex == -1) {
        return const Left(NetworkExceptions.notFound('اللعبة غير موجودة'));
      }

      // Extract that specific game's data
      final Map<String, dynamic> gameData =
          Map<String, dynamic>.from(gamesData[gameIndex]);

      // Get the 'paths' array from this game
      final List<dynamic>? pathsData = gameData['paths'] as List<dynamic>?;
      if (pathsData == null || pathsData.isEmpty) {
        return const Left(
            NetworkExceptions.notFound('لا توجد مسارات في هذه اللعبة'));
      }

      // Find the index of the path whose 'title' matches teamName
      final pathIndex = pathsData.indexWhere((p) => p['title'] == teamName);
      if (pathIndex == -1) {
        return const Left(
            NetworkExceptions.notFound('لا يوجد مسار مطابق لاسم الفريق'));
      }

      // Extract that specific path's data
      final Map<String, dynamic> pathData =
          Map<String, dynamic>.from(pathsData[pathIndex]);

      // Get the 'steps' array from this path
      final List<dynamic>? stepsData = pathData['steps'] as List<dynamic>?;
      if (stepsData == null || stepsData.isEmpty) {
        return const Left(
            NetworkExceptions.notFound('لا توجد خطوات في هذا المسار'));
      }

      // Parse stepIndex (assuming it's a valid integer string)
      final int sIndex;
      try {
        sIndex = int.parse(stepIndex);
      } catch (_) {
        return const Left(
            NetworkExceptions.defaultError('رقم الخطوة غير صالح'));
      }

      if (sIndex < 0 || sIndex >= stepsData.length) {
        return const Left(NetworkExceptions.notFound('رقم الخطوة خارج النطاق'));
      }

      // Mark the specific step as completed
      final Map<String, dynamic> stepData =
          Map<String, dynamic>.from(stepsData[sIndex]);
      print(stepData);
      stepData['completed'] = true;

      // Update the step in the steps array
      stepsData[sIndex] = stepData;
      pathData['steps'] = stepsData;
      pathsData[pathIndex] = pathData;
      gameData['paths'] = pathsData;
      gamesData[gameIndex] = gameData;
      categoryData['games'] = gamesData;

      // Write the updated data back to Firestore
      await categoryDocRef.set(categoryData, SetOptions(merge: true));

      // Parse the updated gamesData into List<GameModel>
      List<GameModel> updatedGames = [];

      for (var game in gamesData) {
        if (game is Map<String, dynamic>) {
          // Check if the game data contains required fields
          if (game.containsKey('title')) {
            try {
              updatedGames.add(GameModel.fromJson(game));
            } catch (e) {
              // Log the error and skip this game
              // Replace with your logging mechanism
              print('Error parsing updated game data: $game');
              continue;
            }
          } else {
            // Log missing required fields and skip this game
            print('Updated game data missing "title" field: $game');
            continue;
          }
        } else {
          // Log invalid game data format and skip
          print('Invalid updated game data format: $game');
          continue;
        }
      }

      if (updatedGames.isEmpty) {
        return const Left(
            NetworkExceptions.notFound('لا توجد ألعاب صالحة بعد التحديث'));
      }

      return Right(updatedGames);
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
