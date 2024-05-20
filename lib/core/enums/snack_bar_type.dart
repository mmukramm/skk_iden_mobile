import 'package:flutter/material.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';

enum SnackBarType {
  primary(scaffoldColor, primaryColor),
  error(scaffoldColor, dangerColor),
  success(scaffoldColor, infoColor);

  final Color textColor;
  final Color backgroundColor;

  const SnackBarType(this.textColor, this.backgroundColor);
}
