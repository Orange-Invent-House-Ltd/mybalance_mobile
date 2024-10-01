import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class AppRichText extends StatelessWidget {
  const AppRichText({
    super.key,
    required this.onSecondaryTap,
    required this.primaryText,
    required this.secondaryText,
    this.secondaryColor,
    this.secondaryFontSize,
    this.letterSpacing,
  });
  final GestureTapCallback onSecondaryTap;
  final String primaryText;
  final String secondaryText;
  final Color? secondaryColor;
  final double? secondaryFontSize;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(
            text: '$primaryText ',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.g200,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = onSecondaryTap,
            text: secondaryText,
            style: theme.textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: secondaryFontSize ?? 16,
              color: secondaryColor ?? AppColors.b300,
              letterSpacing: letterSpacing,
            ),
          ),
        ],
      ),
    );
  }
}
