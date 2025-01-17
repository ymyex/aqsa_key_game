import 'package:aqsa_key_game/core/network/errors/failure.dart';
import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/core/network/remote/dio_helper/dio_helper.dart';
import 'package:aqsa_key_game/features/games/data/models/game_model.dart';
import 'package:aqsa_key_game/features/games/data/repository/games_base_repo.dart';
import 'package:dartz/dartz.dart';

class GamesRepo extends GameBaseRepo {
  @override
  Future<Either<Failure, List<GameModel>>> getGames(
      {required String category}) async {
    try {
      // Prepare query parameters
      Map<String, dynamic> queryParams = {};

      var response = await DioHelper.getData(
          endPoint: '/wp-json/api/courses',
          bearer: CacheHelper.getData(key: "token"),
          mainUrl: true,
          query: queryParams.isNotEmpty ? queryParams : null);

      if (response.statusCode == 200) {
        List<GameModel> courses = List<GameModel>.from(
            response.data.map((x) => GameModel.fromJson(x)));
        return Right(courses);
      }
      return Left(NetworkExceptions.handleResponse(response));
    } catch (error) {
      return Left(NetworkExceptions.getDioException(error));
    }
  }
}
