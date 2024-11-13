import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/sizedbox.dart';
import './filled_icon.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.onTap,
    required this.svgIcon,
    required this.title,
    required this.subTitle,
  });
  final GestureTapCallback onTap;
  final String svgIcon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.p50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledIcon(svgIcon: svgIcon),
            const Height(10),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(4),
            Text(
              subTitle,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: AppColors.g500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
