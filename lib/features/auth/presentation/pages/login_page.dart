import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/utils/keys.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_password_text_field.dart';
import 'package:skk_iden_mobile/features/shared/widget/custom_text_field.dart';
import 'package:skk_iden_mobile/wrapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, DataState<bool>>(
        listener: (_, state) {
          if (state.isFailure) {
            debugPrint("Errorrr");
            debugPrint(state.message.toString());
            navigatorKey.currentState!.pop();
            context.showSnackBar(
              message: state.message ?? "",
            );
          }

          if (state.isSuccess) {
            debugPrint("successs");
            navigatorKey.currentState!.pop();
            navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Wrapper(),
              ),
            );
          }

          if (state.isInProgress) {
            debugPrint("progress");
            context.showLoadingDialog();
          }
        },
        child: Scaffold(
          backgroundColor: primaryBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Image.asset(
                    AssetPath.getImage("logo_iden.png"),
                    height: 52,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textTheme.headlineSmall!,
                      children: const [
                        TextSpan(
                          text: "Surat Kabar Kampus (SKK)\n",
                        ),
                        TextSpan(
                          text: "Identitas Unhas",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: scaffoldColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Login",
                              style: textTheme.headlineMedium,
                            ),
                            SvgPicture.asset(
                              AssetPath.getIcon("login.svg"),
                              colorFilter: const ColorFilter.mode(
                                secondaryBackgroundColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FormBuilder(
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                name: "username",
                                labelText: "Username",
                                hintText: "Username",
                                labelTextAlign: TextAlign.center,
                                validators: [
                                  FormBuilderValidators.required(
                                    errorText: "Bagian ini harus diisi",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CustomPasswordTextField(
                                name: "password",
                                labelText: "Password",
                                hintText: "Masukkan Password",
                                labelTextAlign: TextAlign.center,
                                validators: [
                                  FormBuilderValidators.required(
                                    errorText: "Bagian ini harus diisi",
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (formKey.currentState!.saveAndValidate()) {
                                final value = formKey.currentState!.value;
                                debugPrint("Username: ${value["username"]}");
                                debugPrint("Password: ${value["password"]}");

                                context.read<AuthCubit>().signIn(
                                      SignInParams(
                                        username: value["username"],
                                        password: value["password"],
                                      ),
                                    );
                              }
                            },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: textTheme.titleMedium!.copyWith(
                                color: primaryBackgroundColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

