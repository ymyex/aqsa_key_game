import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/core/shared/widgets/custom_scaffold.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/player/games/cubit/games_cubit.dart';
import 'package:aqsa_key_game/features/player/games/cubit/games_state.dart';
import 'package:aqsa_key_game/features/player/games/game_progress/views/step_page.dart';
import 'package:aqsa_key_game/features/player/games/repository/games_repo.dart';
import 'package:aqsa_key_game/features/player/games/games_listing/views/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayerGamesPage extends StatelessWidget {
  const PlayerGamesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GamesCubit(GamesRepo())..fetchGames(),
      child: BlocBuilder<GamesCubit, GamesStates>(
        builder: (context, state) {
          if (state is GamesLoadingState) {
            return Container(
                color: AppColors.kOffWhiteColor,
                child: const Center(child: CircularProgressIndicator()));
          } else if (state is GamesLoadedState) {
            final games = state.games;

            return CustomScaffold(
              title: 'المسابقات',
              showBackButton: false,
              backgroundImage: BackgroundImage.white,
              backgroundColor: AppColors.kOffWhiteColor,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: games.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1,
                    mainAxisExtent: 164.h,
                  ),
                  itemBuilder: (context, index) {
                    final game = games[index];
                    return GameCard(
                      game: game,
                      onTap: () async {
                        if (game.paths!
                            .firstWhere((p) =>
                                p.title ==
                                CacheHelper.getData(key: 'group_name'))
                            .steps!
                            .every((s) => s.isCompleted == null
                                ? false
                                : s.isCompleted!)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'لقد اتممت هذه اللعبة من قبل.',
                                style: getMediumStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: FontSize.s14),
                              ),
                              backgroundColor: AppColors.kAccentWhiteColor,
                            ),
                          );
                          return;
                        }
                        final shouldRefresh = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StepPage(
                              category: CacheHelper.getData(key: 'category'),
                              gameName: game.title ?? '',
                              initialStepIndex: game.paths!
                                  .firstWhere((p) =>
                                      p.title ==
                                      CacheHelper.getData(key: 'group_name'))
                                  .steps!
                                  .indexWhere((s) => s.isCompleted == null
                                      ? true
                                      : !s.isCompleted!),
                              initialStepModel: game.paths!
                                  .firstWhere((p) =>
                                      p.title ==
                                      CacheHelper.getData(key: 'group_name'))
                                  .steps!
                                  .firstWhere((s) => s.isCompleted == null
                                      ? true
                                      : !s.isCompleted!),
                            ),
                          ),
                        );

                        // Refresh games if returned with true
                        if (shouldRefresh == true) {
                          context.read<GamesCubit>().fetchGames();
                        }
                      },
                    );
                  },
                ),
              ),
            );
          } else if (state is GameErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
