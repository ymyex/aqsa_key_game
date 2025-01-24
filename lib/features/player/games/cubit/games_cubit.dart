import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/features/player/games/cubit/games_state.dart';
import 'package:aqsa_key_game/features/player/games/models/game_model.dart';
import 'package:aqsa_key_game/features/player/games/repository/games_base_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesCubit extends Cubit<GamesStates> {
  final GameBaseRepo gameRepository;
  static GamesCubit get(context) => BlocProvider.of(context);
  static List<GameModel> games = [];

  GamesCubit(this.gameRepository) : super(GamesInitialState());

  /// Fetches a list of games.
  Future<void> fetchGames() async {
    emit(GamesLoadingState());

    var response = await gameRepository.getGames(
        category: CacheHelper.getData(key: 'category'));

    response.fold((failure) {
      emit(GameErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (resGames) {
      games = resGames;
      emit(GamesLoadedState(resGames));
    });
  }

  Future<void> markStepCompleted(int stepIndex, String gameName) async {
    emit(GamesLoadingState());

    var response = await gameRepository.markStepCompleted(
        category: CacheHelper.getData(key: 'category'),
        gameName: gameName,
        teamName: CacheHelper.getData(key: 'group_name'),
        stepIndex: stepIndex.toString());

    response.fold((failure) {
      emit(GameErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (resGames) {
      games = resGames;
      emit(GamesLoadedState(resGames));
    });
  }
}
