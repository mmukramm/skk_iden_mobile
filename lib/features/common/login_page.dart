import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skk_iden_mobile/core/asset_helper.dart';
import 'package:skk_iden_mobile/core/colors.dart';
import 'package:skk_iden_mobile/core/text_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
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
                        colorFilter: ColorFilter.mode(
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
                    child: const Column(
                      children: [
                        CustomTextField(
                          name: "username",
                          labelText: "Username",
                          hintText: "Username",
                          labelTextAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CustomPasswordTextField(
                          name: "password",
                          labelText: "Password",
                          hintText: "Masukkan Password",
                          labelTextAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {},
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
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String name, labelText, hintText;
  final TextAlign labelTextAlign;

  const CustomTextField({
    super.key,
    required this.name,
    required this.labelText,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
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
        ),
      ],
    );
  }
}

class CustomPasswordTextField extends StatefulWidget {
  final String name, labelText, hintText;
  final TextAlign labelTextAlign;

  const CustomPasswordTextField({
    super.key,
    required this.name,
    required this.labelText,
    required this.hintText,
    this.labelTextAlign = TextAlign.start,
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
    isVisible = ValueNotifier(false);
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
                        ColorFilter.mode(primaryColor, BlendMode.srcIn),
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
