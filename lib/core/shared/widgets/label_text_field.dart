import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_colors.dart';
import 'sizedbox.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.initialText,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.labelColor,
    this.readOnly = false,
    this.onTap,
    this.style,
    this.inputFormatters,
    this.isDescription = false,
    this.maxLength,
    this.isLoading = false,
  });
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? initialText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String?>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? labelColor;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDescription;
  final int? maxLength;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.g400,
          ),
        ),
        const Height(6.0),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          initialValue: initialText,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          inputFormatters: inputFormatters,
          style: style ??
              theme.textTheme.bodyLarge?.copyWith(color: AppColors.b300),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            suffixIconConstraints: isLoading
                ? const BoxConstraints(
                    minHeight: 24,
                    minWidth: 24,
                    maxWidth: 24,
                    maxHeight: 24,
                  )
                : null,
          ),
          maxLines: isDescription ? 4 : 1,
          minLines: isDescription ? 4 : 1,
          maxLength: maxLength,
        ),
      ],
    );
  }
}
