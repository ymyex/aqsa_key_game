import 'package:aqsa_key_game/core/network/local/cache_helper.dart';
import 'package:aqsa_key_game/core/shared/widgets/cached_nework_image.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/player/games/game_progress/views/step_page.dart';
import 'package:aqsa_key_game/features/player/games/models/game_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameCard extends StatefulWidget {
  final GameModel game;
  final Function() onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  GameCardState createState() => GameCardState();
}

class GameCardState extends State<GameCard> {
  bool isIconClicked = false; // To manage icon click state

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          // Main image
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedImage(
              url:
                  'https://img.freepik.com/premium-photo/3d-wallpaper-al-aqsa-mosque-palestine_616652-3281.jpg',
              height: 156.h,
              width: double.infinity,
              boxShap: BoxShape.rectangle,
              boxfit: BoxFit.cover,
            ),
          ),
          // Bottom center text container
          Positioned(
            bottom: 0,
            left: 10.w,
            right: 10.w,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 52.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x66EEEEEE),
                      blurRadius: 32.r,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: AutoSizeText(
                    widget.game.title!,
                    maxLines: 2,
                    minFontSize: FontSize.s12,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom right clickable icon
          // Positioned(
          //   bottom: 60.h,
          //   right: 8.w,
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         color: AppColors.kPrimaryColor,
          //         borderRadius: BorderRadius.circular(12.r),
          //       ),
          //       child: SvgPicture.asset(
          //           // widget.game.isEnrolled!
          //           AssetsData.enrolledIcon
          //           // : AssetsData.unenrolledIcon,
          //           ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
