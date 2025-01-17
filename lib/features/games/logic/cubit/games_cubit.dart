import 'package:aqsa_key_game/core/network/errors/network_exceptions.dart';
import 'package:aqsa_key_game/features/games/data/models/game_model.dart';
import 'package:aqsa_key_game/features/games/data/repository/games_base_repo.dart';
import 'package:aqsa_key_game/features/games/logic/cubit/games_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamesCubit extends Cubit<GamesStates> {
  final GameBaseRepo gameRepository;
  static GamesCubit get(context) => BlocProvider.of(context);
  static List<GameModel> courses = [];

  GamesCubit(this.gameRepository) : super(GamesInitialState());

  /// Fetches a list of games.
  Future<void> fetchGames({required String category}) async {
    emit(GamesLoadingState());

    var response = await gameRepository.getGames(category: category);

    response.fold((failure) {
      emit(GameErrorState(
          NetworkExceptions.getErrorMessage(failure as NetworkExceptions)));
    }, (resCourses) {
      courses = resCourses;
      emit(GamesLoadedState(resCourses));
    });
  }
}
