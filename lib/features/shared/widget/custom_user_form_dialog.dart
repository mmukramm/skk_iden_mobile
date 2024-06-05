import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/enums/role_type.dart';

import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_password_text_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';
import 'package:skk_iden_mobile/features/users/data/models/user_model.dart';

class CustomUserFormDialog extends StatefulWidget {
  final String title;
  final GlobalKey<FormBuilderState> formKey;
  final UserModel? userModel;
  final VoidCallback onTapPrimaryButton;

  const CustomUserFormDialog({
    super.key,
    required this.title,
    required this.formKey,
    required this.onTapPrimaryButton,
    this.userModel,
  });

  @override
  State<CustomUserFormDialog> createState() => _CustomUserFormDialogState();
}

class _CustomUserFormDialogState extends State<CustomUserFormDialog> {
  late final ValueNotifier<bool> isConfirmPasswordSame;
  late final ValueNotifier<bool> showPasswordForm;
  late final ValueNotifier<RoleType?> roleDropdownValue;

  late String password;

  @override
  void initState() {
    super.initState();
    isConfirmPasswordSame = ValueNotifier(true);
    showPasswordForm = ValueNotifier(widget.userModel == null);
    roleDropdownValue = ValueNotifier(widget.userModel == null
        ? null
        : widget.userModel!.isAdmin
            ? RoleType.admin
            : RoleType.user);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    key: widget.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          name: "fullname",
                          labelText: "Nama",
                          hintText: "Masukkan nama",
                          initialValue: widget.userModel?.name,
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
                          initialValue: widget.userModel?.username,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Role',
                              style: textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            FormBuilderDropdown<RoleType>(
                              name: 'role',
                              dropdownColor: primaryBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              style: textTheme.bodyLarge,
                              initialValue: widget.userModel == null
                                  ? null
                                  : widget.userModel!.isAdmin
                                      ? RoleType.admin
                                      : RoleType.user,
                              elevation: 0,
                              isDense: true,
                              decoration: InputDecoration(
                                hintText: 'Pilih role',
                                hintStyle: textTheme.bodyLarge!.copyWith(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem<RoleType>(
                                  value: RoleType.admin,
                                  child: Text('Admin'),
                                ),
                                DropdownMenuItem<RoleType>(
                                  value: RoleType.user,
                                  child: Text('User'),
                                ),
                              ],
                              onChanged: (result) {
                                roleDropdownValue.value = result;
                              },
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Role belum dipilih')
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (widget.userModel != null)
                          FilledButton(
                            onPressed: () {
                              showPasswordForm.value = !showPasswordForm.value;
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                            ),
                            child: const Text('Ubah Password'),
                          ),
                        const SizedBox(
                          height: 4,
                        ),
                        ValueListenableBuilder(
                          valueListenable: showPasswordForm,
                          builder: (context, value, _) {
                            return value
                                ? Column(
                                    children: [
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
                                                labelText:
                                                    'Konfirmasi Password',
                                                hintText: '******',
                                                onChange: (result) {
                                                  isConfirmPasswordSame.value =
                                                      password == result;
                                                  debugPrint(value.toString());
                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .required(
                                                    errorText:
                                                        "Bagian ini harus diisi",
                                                  ),
                                                ],
                                              ),
                                              if (!value)
                                                Text(
                                                  'Password dan Konfirmasi password tidak sama',
                                                  style: textTheme.bodySmall!
                                                      .copyWith(
                                                    color: dangerColor,
                                                  ),
                                                ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox();
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
                            widget.userModel == null ? "Tambah" : "Edit",
                            style: textTheme.titleMedium!.copyWith(
                              color: scaffoldColor,
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
