import 'package:flutter/material.dart';
import 'package:skk_iden_mobile/core/keys.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';

extension SnackBarExtension on BuildContext {
  showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const Loading(),
    );
  }

  showSnackBar({
    required String message,
    Color backgroundColor = primaryColor,
    Color textColor = scaffoldColor,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: textTheme.bodyMedium!.copyWith(
          color: scaffoldColor,
        ),
      ),
      backgroundColor: primaryColor,
      duration: const Duration(milliseconds: 4000),
    );
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }
}
