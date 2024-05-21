import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:skk_iden_mobile/core/theme/colors.dart';
import 'package:skk_iden_mobile/core/theme/text_theme.dart';

class CustomSearchField extends StatefulWidget {
  final String name, hintText;
  final String? labelText;
  final TextAlign labelTextAlign;
  final ValueChanged<String?>? onChange;
  final List<String? Function(String?)>? validators;
  final Duration duration;
  final bool delayOnChanged;
  final VoidCallback? onClickClearIcon;

  const CustomSearchField({
    super.key,
    required this.name,
    this.labelText,
    required this.hintText,
    this.duration = const Duration(milliseconds: 500),
    this.labelTextAlign = TextAlign.start,
    this.onChange,
    this.delayOnChanged = true,
    this.validators,
    this.onClickClearIcon,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late final TextEditingController textEditingController;
  late final ValueNotifier<bool> showClearButton;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    showClearButton = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.clear();
    showClearButton.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText != null)
          Text(
            widget.labelText!,
            textAlign: widget.labelTextAlign,
            style: textTheme.titleMedium,
          ),
        const SizedBox(
          height: 4,
        ),
        FormBuilderTextField(
          controller: textEditingController,
          name: widget.name,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.bodyLarge!.copyWith(
              color: secondaryColor,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: ValueListenableBuilder(
              valueListenable: showClearButton,
              builder: (_, value, __) =>
                  value ? buildSuffixIcon() : const SizedBox(),
            ),
          ),
          onChanged: widget.delayOnChanged
              ? (value) {
                  showClearButton.value = value!.isNotEmpty;
                  debounce(() => widget.onChange!(value));
                }
              : widget.onChange,
          validator: widget.validators != null
              ? FormBuilderValidators.compose(widget.validators!)
              : null,
        ),
      ],
    );
  }

  Widget buildSuffixIcon() {
    return IconButton(
      onPressed: () {
        widget.onClickClearIcon != null ? widget.onClickClearIcon!() : null;
        textEditingController.clear();
      },
      icon: const Icon(
        Icons.close,
        color: primaryColor,
      ),
    );
  }

  void debounce(VoidCallback voidCallback) {
    timer?.cancel();
    timer = Timer(widget.duration, voidCallback);
  }
}
