import 'package:aqsa_key_game/core/shared/widgets/custom_scaffold.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/features/games/data/repository/games_repo.dart';
import 'package:aqsa_key_game/features/games/logic/cubit/games_cubit.dart';
import 'package:aqsa_key_game/features/games/logic/cubit/games_state.dart';
import 'package:aqsa_key_game/features/games/views/widgets/game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({
    super.key,
  });

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GamesCubit(GamesRepo()),
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
              showBackButton: true,
              backgroundImage: BackgroundImage.white,
              backgroundColor: AppColors.kBackgroundGreyColor,
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
                    return GameCard(game: game);
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
