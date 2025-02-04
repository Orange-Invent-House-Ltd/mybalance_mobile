import 'package:flutter/material.dart';
import '../../../config/themes/app_colors.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
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
  });
  final TextEditingController controller;
  final String label;
  final String? hintText;
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.g400,
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          style: style ??
              const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.b300,
              ),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
