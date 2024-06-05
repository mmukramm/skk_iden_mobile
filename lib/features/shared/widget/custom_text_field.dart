import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String name, hintText;
  final String? labelText;
  final int maxLines;
  final String? initialValue;
  final TextAlign labelTextAlign;
  final List<String? Function(String?)>? validators;

  const CustomTextField({
    super.key,
    required this.name,
    this.labelText,
    this.maxLines = 1,
    required this.hintText,
    this.initialValue,
    this.labelTextAlign = TextAlign.start,
    this.validators,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (labelText != null)
          Text(
            labelText!,
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
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: maxLines,
          initialValue: initialValue,
          validator: validators != null
              ? FormBuilderValidators.compose(validators!)
              : null,
        ),
      ],
    );
  }
}
