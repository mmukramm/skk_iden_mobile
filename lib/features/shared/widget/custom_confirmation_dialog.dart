import 'package:flutter/material.dart';

import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onTapPrimaryButton;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onTapPrimaryButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: scaffoldColor,
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 32,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Text(
                        title,
                        style: textTheme.titleLarge!.copyWith(
                          color: scaffoldColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      navigatorKey.currentState!.pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: scaffoldColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    message,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: secondaryBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => navigatorKey.currentState!.pop(),
                          child: Text(
                            "Batal",
                            style: textTheme.bodyLarge!.copyWith(
                              color: primaryBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: onTapPrimaryButton,
                          child: Text(
                            "Hapus",
                            style: textTheme.titleMedium!.copyWith(
                              color: primaryBackgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
