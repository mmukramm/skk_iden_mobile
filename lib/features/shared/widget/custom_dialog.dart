// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final VoidCallback onTapPrimaryButton;
  final GlobalKey<FormBuilderState> formKey;

  const CustomDialog({
    super.key,
    required this.title,
    required this.onTapPrimaryButton,
    required this.formKey,
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
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          name: "keyword",
                          labelText: "Kata Kunci",
                          hintText: "Masukkan kata kunci",
                          validators: [
                            FormBuilderValidators.required(
                              errorText: "Bagian ini harus diisi",
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextField(
                          name: "definition",
                          labelText: "Deskripsi",
                          hintText: "Masukkan deskripsi",
                          maxLines: 4,
                          validators: [
                            FormBuilderValidators.required(
                              errorText: "Bagian ini harus diisi",
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
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
                            "Tambah",
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
