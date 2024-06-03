import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/helper/asset_helper.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String name, labelText, hintText;
  final TextAlign labelTextAlign;
  final Function(String?)? onChange;
  final List<String? Function(String?)>? validators;

  const CustomPasswordTextField({
    super.key,
    required this.name,
    required this.labelText,
    required this.hintText,
    this.onChange,
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
              onChanged: widget.onChange,
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
