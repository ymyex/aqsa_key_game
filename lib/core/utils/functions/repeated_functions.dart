import 'package:aqsa_key_game/core/shared/widgets/action_button.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';
import 'package:aqsa_key_game/core/utils/helper/spacing.dart';
import 'package:aqsa_key_game/core/utils/styles/font_manager.dart';
import 'package:aqsa_key_game/core/utils/styles/text_style_manger.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RepeatedFunctions {
  static bool isArabic() => Intl.getCurrentLocale() == 'ar';
  // static Future<List<ConnectivityResult>> checkConductivity() async {
  //   return await (Connectivity().checkConnectivity());
  // }

  static showSnackBar(
    BuildContext context, {
    required String message,
    Color? textColor,
    Color? background,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: getMediumStyle(
              fontSize: FontSize.s14,
              color: error ? AppColors.kRedColor : AppColors.kPrimaryColor,
              fontFamily: FontConstants.notoSansArabic),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor:
            error ? AppColors.kLightRedColor : const Color(0xffFFF9F4),
        // backgroundColor: background ?? AppColors.black,
      ),
    );
  }

  static String formatAudioDuration(double seconds) {
    // Convert the double to an integer by flooring to remove decimal places
    int totalSeconds = seconds.floor();

    // Calculate minutes by dividing total seconds by 60
    int minutes = totalSeconds ~/ 60;

    // Calculate remaining seconds using modulus operator
    int remainingSeconds = totalSeconds % 60;

    // Format minutes and seconds as strings
    String minutesStr = minutes.toString();
    String secondsStr =
        remainingSeconds.toString().padLeft(2, '0'); // Ensures two digits

    // Combine minutes and seconds with a colon separator
    return '$minutesStr:$secondsStr';
  }

  // utils.dart
  static String getYouTubeVideoId(String url) {
    Uri uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (url.contains('www.youtube.com/shorts')) {
      return uri.pathSegments.last;
    } else if (uri.host.contains('youtube.com') ||
        uri.host.contains('www.youtube.com')) {
      return uri.queryParameters['v'] ?? '';
    }
    return '';
  }

  static String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg'; // You can use 0.jpg, 1.jpg, 2.jpg, etc. for different resolutions
  }

  /// Calculates the scaled size of an image to fit the screen width while maintaining aspect ratio.
  ///
  /// [context]: BuildContext to access MediaQuery for screen width.
  /// [originalWidth]: The original width of the image.
  /// [originalHeight]: The original height of the image.
  ///
  /// Returns a [Size] object containing the scaled width and height.
  static Size getScaledSize(double newWidth, originalWidth, originalHeight) {
    // Calculate the aspect ratio
    double aspectRatio;
    if (originalWidth is int) {
      aspectRatio = originalHeight.toDouble() / originalWidth.toDouble();
    } else {
      aspectRatio = double.parse(originalHeight) / double.parse(originalWidth);
    }
    // Calculate the scaled height to maintain aspect ratio
    double scaledHeight = newWidth.toDouble() * aspectRatio;
    return Size(newWidth, scaledHeight);
  }

  static showCustomDialog(context, String body,
      {String? primaryText,
      String? secondryText,
      Function()? onPrimaryTap,
      Function()? onSecondryTap}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          insetPadding: const EdgeInsets.all(48),
          backgroundColor: AppColors.kLightGreyColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  body,
                  style: getMediumStyle(fontSize: FontSize.s14),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (secondryText != null)
                      ActionButton(
                          onTap: onSecondryTap ??
                              () {
                                Navigator.pop(context);
                              },
                          color: ColorStyle.white,
                          verticalPadding: 12,
                          horizontalPadding: 40,
                          child: Text(
                            secondryText,
                            style: getMediumStyle(fontSize: FontSize.s14),
                          )),
                    if (primaryText != null)
                      ActionButton(
                          onTap: onPrimaryTap,
                          verticalPadding: 12,
                          horizontalPadding: 40,
                          child: Text(
                            primaryText,
                            style: getMediumStyle(
                                fontSize: FontSize.s14,
                                color: AppColors.kWhiteColor),
                          )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // static Future<void> launchCustomUrl(context, String? url) async {
  //   if (url != null) {
  //     Uri uri = Uri.parse(url);

  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri);
  //     } else {
  //       customSnackBar(context, 'Cannot launch $url');
  //     }
  //   }
  // }
}
