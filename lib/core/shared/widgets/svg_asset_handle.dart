import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVGAssetHandler extends StatelessWidget {
  final String svgPath;
  final double svgWidth;
  final double svgheight;
  final Color? svgColor;
  final BoxFit boxFit;

  const SVGAssetHandler(
      {super.key,
      required this.svgPath,
      required this.svgWidth,
      required this.boxFit,
      required this.svgheight,
      this.svgColor});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgPath,
        fit: boxFit,
        width: svgWidth,
        height: svgheight,
        colorFilter: svgColor != null
            ? ColorFilter.mode(svgColor!, BlendMode.srcIn)
            : null);
  }
}
