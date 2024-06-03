import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';

class NoDataFound extends StatelessWidget {
  final String message;
  final double svgHeight;

  const NoDataFound({
    super.key,
    this.message = "No data found",
    this.svgHeight = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          height: svgHeight,
          AssetPath.getIllustration('no-data-found.svg'),
        ),
        Text(
          message,
          style: textTheme.titleLarge!.copyWith(
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
