import 'package:flutter/material.dart';
import 'package:mybalanceapp/config/themes/app_colors.dart';
import 'package:mybalanceapp/core/widgets/app_back_button.dart';
import 'package:mybalanceapp/core/widgets/sizedbox.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required this.theme,
    this.text,
  });
  final ThemeData theme;
  final String? text;
  @override
  Color? get backgroundColor => theme.scaffoldBackgroundColor;

  @override
  double? get scrolledUnderElevation => 0;

  @override
  Widget? get leading => const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Width(25),
          AppBackButton(),
        ],
      );

  @override
  Widget? get title => text != null
      ? Text(
          text!,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 23,
            color: AppColors.b300,
          ),
        )
      : super.title;
}
