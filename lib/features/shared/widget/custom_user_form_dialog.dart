import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_password_text_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';

class CustomUserFormDialog extends StatefulWidget {
  final String title;
  final VoidCallback onTapPrimaryButton;

  const CustomUserFormDialog({
    super.key,
    required this.title,
    required this.onTapPrimaryButton,
  });

  @override
  State<CustomUserFormDialog> createState() => _CustomUserFormDialogState();
}

class _CustomUserFormDialogState extends State<CustomUserFormDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  late final ValueNotifier<bool> isConfirmPasswordSame;
  late String password;

  @override
  void initState() {
    super.initState();
    isConfirmPasswordSame = ValueNotifier(true);
    password = '';
  }

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
                        widget.title,
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
                          name: "fullname",
                          labelText: "Nama",
                          hintText: "Masukkan nama",
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
                          name: "username",
                          labelText: "Username",
                          hintText: "Masukkan username",
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
                          name: "role",
                          labelText: "Role",
                          hintText: "Pilih Role",
                          validators: [
                            FormBuilderValidators.required(
                              errorText: "Bagian ini harus diisi",
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomPasswordTextField(
                          name: 'password',
                          labelText: 'Password',
                          hintText: '******',
                          onChange: (result) {
                            password = result!;
                          },
                          validators: [
                            FormBuilderValidators.required(
                              errorText: "Bagian ini harus diisi",
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ValueListenableBuilder(
                          valueListenable: isConfirmPasswordSame,
                          builder: (context, value, _) {
                            return Column(
                              children: [
                                CustomPasswordTextField(
                                  name: 'confirmPassword',
                                  labelText: 'Konfirmasi Password',
                                  hintText: '******',
                                  onChange: (result) {
                                    isConfirmPasswordSame.value =
                                        password == result;
                                    debugPrint(value.toString());
                                  },
                                  validators: [
                                    FormBuilderValidators.required(
                                      errorText: "Bagian ini harus diisi",
                                    )
                                  ],
                                ),
                                if (!value)
                                  Text(
                                    'Password dan Konfirmasi password tidak sama',
                                    style: textTheme.bodySmall!.copyWith(
                                      color: dangerColor,
                                    ),
                                  ),
                              ],
                            );
                          },
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
                          onPressed: widget.onTapPrimaryButton,
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
