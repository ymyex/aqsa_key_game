import 'package:flutter/material.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/shared/widgets/action_button.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:aqsa_key_game/features/layout/logic/cubit/layout_cubit.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  // Root of the application
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Full-Screen Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      AssetsData.welcomeBackground), // Path to your image
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
            // Main Container with Rounded Corners
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(56),
                      // "Salam," Text
                      Text('السَّلَامُ عَلَيْكُمْ،',
                          style: getExtraBoldStyle(
                              fontSize: FontSize.s40,
                              color: AppColors.kWhiteColor)),
                      // "Welcome to About Islam" Text
                      Text('حَيَّاكُمُ اللَّهُ',
                          style: getExtraBoldStyle(
                              fontSize: FontSize.s20,
                              color: AppColors.kWhiteColor)),
                      // Subtitle Text
                      verticalSpace(4),
                      Text(
                          'رِحْلَةُ البَحْثِ عَنْ مِفْتَاحِ الأَقْصَى تَبْدَأُ مِنْ هُنَا',
                          style: getMediumStyle(color: AppColors.kWhiteColor)),
                    ],
                  ),
                  // Buttons ("Login" and "Register")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Login Button
                        ActionButton(
                            onTap: () {
                              LayoutCubit.get(context).changeButtonNavItem(2);
                            },
                            child: Center(
                              child: Text(
                                "لاعب",
                                style: getExtraBoldStyle(
                                    fontSize: FontSize.s16,
                                    color: AppColors.kWhiteColor),
                              ),
                            )),
                        verticalSpace(20),
                        // Register Button
                        ActionButton(
                            onTap: () {
                              LayoutCubit.get(context).changeButtonNavItem(1);
                            },
                            color: ColorStyle.white,
                            child: Center(
                              child: Text(
                                "مشرف",
                                style: getExtraBoldStyle(
                                  fontSize: FontSize.s16,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
