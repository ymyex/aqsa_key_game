import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aqsa_key_game/core/constant/assets_data.dart';
import 'package:aqsa_key_game/core/shared/widgets/svg_asset_handle.dart';
import 'package:aqsa_key_game/core/utils/colors/app_colors.dart';

class ItemFloatingButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const ItemFloatingButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20.h),
        Container(
          height: 64.r,
          width: 64.r,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  AppColors.kPrimary1Color,
                  AppColors.kPrimary2Color
                ]),
            shape: BoxShape.circle,
          ),
          child: Material(
            elevation: 0,
            borderOnForeground: false,
            shadowColor: Colors.transparent,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: onTap,
              child: Center(
                  child: SVGAssetHandler(
                      svgPath: AssetsData.chatIcon,
                      svgWidth: 26.w,
                      boxFit: BoxFit.scaleDown,
                      svgheight: 26.h)),
            ),
          ),
        ),
      ],
    );
  }
}
