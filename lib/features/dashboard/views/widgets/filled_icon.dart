import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybalanceapp/config/themes/app_colors.dart';

class FilledIcon extends StatelessWidget {
  const FilledIcon({
    super.key,
    required this.svgIcon,
    this.backgroundColor,
  });
  final String svgIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.p500,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SvgPicture.asset(svgIcon),
    );
  }
}
