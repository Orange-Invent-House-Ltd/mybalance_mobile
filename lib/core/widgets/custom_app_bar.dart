import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybalanceapp/config/themes/app_colors.dart';
import 'package:mybalanceapp/core/widgets/app_back_button.dart';
import 'package:mybalanceapp/core/widgets/sizedbox.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required this.theme,
    this.text,
    this.action,
    this.onBack,
  });
  final ThemeData theme;
  final String? text;
  final Widget? action;
  final VoidCallback? onBack;
  @override
  Color? get backgroundColor => theme.scaffoldBackgroundColor;

  @override
  double? get scrolledUnderElevation => 0;

  @override
  Widget? get leading => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Width(24),
          AppBackButton(onBackPressed: onBack),
        ],
      );

  @override
  Widget? get title => text != null
      ? Text(
          text!,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 23.sp,
            color: AppColors.b300,
          ),
        )
      : super.title;

  @override
  List<Widget>? get actions =>
      action != null ? [action!, const Width(8)] : null;
}
