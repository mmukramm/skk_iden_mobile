import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skk_iden_mobile/core/enums/snack_bar_type.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_user_form_dialog.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_confirmation_dialog.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_add_keyword_dialog.dart';
import 'package:skk_iden_mobile/features/shared/widget/loading.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';

extension SnackBarExtension on BuildContext {
  showSnackBar({
    required String message,
    Color backgroundColor = primaryColor,
    Color textColor = scaffoldColor,
    SnackBarType type = SnackBarType.primary,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium!.copyWith(
          color: type.textColor,
        ),
      ),
      backgroundColor: type.backgroundColor,
      duration: const Duration(milliseconds: 4000),
    );
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(
        snackBar,
      );
  }
}

extension CustomDialogExtension on BuildContext {
  Future<Object?> showLoadingDialog() {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (_) => const Loading(),
    );
  }

  Future<Object?> showConfirmationDialog({
    required String title,
    required String message,
    required VoidCallback onTapPrimaryButton,
  }) {
    return showDialog(
      context: this,
      builder: (_) => CustomConfirmationDialog(
        title: title,
        message: message,
        onTapPrimaryButton: onTapPrimaryButton,
      ),
    );
  }

  Future<Object?> showAddKeywordDialog({
    required String title,
    required VoidCallback onTapPrimaryButton,
    required GlobalKey<FormBuilderState> formKey,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => CustomAddKeywordDialog(
        title: title,
        onTapPrimaryButton: onTapPrimaryButton,
        formKey: formKey,
      ),
    );
  }

  Future<Object?> showAddUserDialog({
    required String title,
    required VoidCallback onTapPrimaryButton,
    required GlobalKey<FormBuilderState> formKey,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => CustomUserFormDialog(
        title: title,
        formKey: formKey,
        onTapPrimaryButton: onTapPrimaryButton,
      ),
    );
  }

  Future<Object?> showEditUserDialog({
    required String title,
    required UserModel userModel,
    required VoidCallback onTapPrimaryButton,
    required GlobalKey<FormBuilderState> formKey,
  }) {
    return showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => CustomUserFormDialog(
        title: title,
        formKey: formKey,
        userModel: userModel,
        onTapPrimaryButton: onTapPrimaryButton,
      ),
    );
  }
}
