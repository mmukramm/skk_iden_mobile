import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/credential_saver.dart';
import 'package:skk_iden_mobile/core/preferences/asset_helper.dart';
import 'package:skk_iden_mobile/core/extensions/extension.dart';
import 'package:skk_iden_mobile/core/keys.dart';
import 'package:skk_iden_mobile/core/state/data_state.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';
import 'package:skk_iden_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:skk_iden_mobile/features/auth/presentation/bloc/auth_cubit.dart';
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
    debugPrint(CredentialSaver.accessToken);
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

class CustomTextField extends StatelessWidget {
  final String name, labelText, hintText;
  final TextAlign labelTextAlign;
  final List<String? Function(String?)>? validators;

  const CustomTextField({
    super.key,
    required this.name,
    required this.labelText,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          labelText,
          textAlign: labelTextAlign,
          style: textTheme.titleMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        FormBuilderTextField(
          name: name,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: textTheme.bodyLarge!.copyWith(
              color: secondaryColor,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: validators != null
              ? FormBuilderValidators.compose(validators!)
              : null,
        ),
      ],
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final String name, labelText, hintText;
  final TextAlign labelTextAlign;
  final List<String? Function(String?)>? validators;

  const CustomPasswordTextField({
    super.key,
    required this.name,
    required this.labelText,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
    this.validators,
  });

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  late final ValueNotifier<bool> isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = ValueNotifier(true);
  }

  @override
  void dispose() {
    super.dispose();
    isVisible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.labelText,
          textAlign: widget.labelTextAlign,
          style: textTheme.titleMedium,
        ),
        const SizedBox(
          height: 4,
        ),
        ValueListenableBuilder(
          valueListenable: isVisible,
          builder: (context, value, child) {
            return FormBuilderTextField(
              name: widget.name,
              obscureText: value,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: textTheme.bodyLarge!.copyWith(
                  color: secondaryColor,
                ),
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    isVisible.value = !value;
                  },
                  icon: SvgPicture.asset(
                    value
                        ? AssetPath.getIcon("eye_close.svg")
                        : AssetPath.getIcon("eye_open.svg"),
                    colorFilter:
                        const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              validator: widget.validators != null
                  ? FormBuilderValidators.compose(widget.validators!)
                  : null,
            );
          },
        ),
      ],
    );
  }
}
