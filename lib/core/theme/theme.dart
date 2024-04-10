import 'package:flutter/material.dart';
import 'package:skk_iden_mobile/core/colors.dart';
import 'package:skk_iden_mobile/core/text_theme.dart';

ThemeData get lightTheme {
  return ThemeData.from(
    colorScheme: colorScheme,
    textTheme: textTheme,
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: scaffoldColor,
    primaryColor: primaryColor,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

ColorScheme colorScheme = ColorScheme.fromSeed(
  seedColor: primaryBackgroundColor,
  primary: primaryColor,
  secondary: secondaryColor,
  background: primaryBackgroundColor,
  onBackground: primaryColor,
  onPrimary: primaryBackgroundColor,
  onSecondary: secondaryBackgroundColor,
);

ThemeData lightThemes = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryBackgroundColor,
      primary: primaryColor,
      secondary: secondaryColor,
      background: primaryBackgroundColor,
      onBackground: primaryColor,
      onPrimary: primaryBackgroundColor,
      onSecondary: secondaryBackgroundColor,
      error: dangerColor
    ),
    scaffoldBackgroundColor: scaffoldColor,
    primaryColor: primaryColor);
