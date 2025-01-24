import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/shared/widgets/custom_appbar.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

// Define the enumeration
enum BackgroundImage {
  green,
  white,
  none,
}

class CustomScaffold extends StatelessWidget {
  final dynamic title;
  final String? badgeName;
  final bool showAppBar;
  final bool showBackButton;
  final Color backgroundColor;
  final Function()? onBack;
  final BackgroundImage backgroundImage;
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.body,
    this.title,
    this.onBack,
    this.showAppBar = true,
    this.showBackButton = true,
    this.backgroundColor = AppColors.kOffWhiteColor,
    this.backgroundImage = BackgroundImage.green, // Default to green
    this.badgeName,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the SVG asset based on the backgroundImageType
    String? backgroundAsset;
    switch (backgroundImage) {
      case BackgroundImage.green:
        backgroundAsset = AssetsData.islamicGraphicGreen;
        break;
      case BackgroundImage.white:
        backgroundAsset =
            AssetsData.islamicGraphicWhite; // Ensure this asset exists
        break;
      case BackgroundImage.none:
        backgroundAsset = null;
        break;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            // Background Islamic graphic image if enabled
            if (backgroundAsset != null)
              Positioned(
                top: -30.h,
                child: SvgPicture.asset(
                  backgroundAsset,
                ),
              ),
            // Main content with optional AppBar
            Column(
              children: [
                if (showAppBar)
                  CustomAppbar(
                    title: title ?? '',
                    showBackButton: showBackButton,
                    badgeName: badgeName,
                    onBack: onBack,
                  ),
                // Main body content
                Expanded(
                  child: body,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
