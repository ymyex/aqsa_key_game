import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/functions/repeated_functions.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:flutter/material.dart';

TextStyle _getTextStyle(
  double fontSize,
  FontWeight fontWeight,
  Color color,
  String? fontFamily,
) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily ??
          (RepeatedFunctions.isArabic()
              ? FontConstants.notoSansArabic
              : FontConstants.notoSansArabic),
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle({
  double? fontSize,
  Color? color,
  String? fontFamily,
}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.regular,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}

// medium style

TextStyle getMediumStyle(
    {double? fontSize,
    Color? color,
    String? fontFamily,
    bool isItalic = false}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.medium,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}

// medium style

TextStyle getLightStyle(
    {double? fontSize,
    Color? color,
    String? fontFamily,
    bool isItalic = false}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.light,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}

// bold style

TextStyle getBoldStyle(
    {double? fontSize,
    Color? color,
    String? fontFamily,
    bool isItalic = false}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.bold,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}

// semibold style

TextStyle getSemiBoldStyle(
    {double? fontSize,
    Color? color,
    String? fontFamily,
    bool isItalic = false}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.semiBold,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}

TextStyle getExtraBoldStyle(
    {double? fontSize,
    Color? color,
    String? fontFamily,
    bool isItalic = false}) {
  return _getTextStyle(
    fontSize ?? FontSize.s12,
    FontWeightManager.extraBold,
    color ?? AppColors.kBlackColor,
    fontFamily,
  );
}
