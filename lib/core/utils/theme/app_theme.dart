import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
      primaryColor: AppColors.kPrimaryColor,
      primaryColorLight: AppColors.kGreyColor,
      disabledColor: AppColors.kGreyColor,
      scaffoldBackgroundColor: AppColors.kOffWhiteColor,
      canvasColor: AppColors.kWhiteColor,
      highlightColor: Colors.transparent,
      useMaterial3: true,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.kPrimaryColor,
        selectionColor: AppColors.kPrimaryColor,
        selectionHandleColor: AppColors.kPrimaryColor,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.kPrimaryColor,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
      radioTheme: RadioThemeData(
          fillColor: WidgetStateColor.resolveWith(
              (states) => AppColors.kLightGreyColor),
          splashRadius: 0));
}
