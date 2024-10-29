import 'package:flutter/material.dart';
import 'package:mybalanceapp/config/themes/app_colors.dart';
import 'package:mybalanceapp/core/widgets/sizedbox.dart';

class OurChargesCard extends StatelessWidget {
  const OurChargesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      elevation: 4,
      color: AppColors.w50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(11, 16, 36, 13),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our charges',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.g200,
              ),
            ),
            const Height(12),
            Text(
              'We offer very user friendly charges which are range-based. The higher the transaction, the lower the charge percentage.',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13,
                color: AppColors.g200,
              ),
            ),
            const Height(16),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Range',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.g200,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    'Charges',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: AppColors.g200,
                    ),
                  ),
                ),
              ],
            ),
            const Height(12),
            charges(theme.textTheme.labelMedium, 'Below N100,000', 1.5),
            const Height(16),
            charges(theme.textTheme.labelMedium, 'N100,000 - N500,000', 1),
            const Height(16),
            charges(theme.textTheme.labelMedium, 'Above N500,000', 0.8),
          ],
        ),
      ),
    );
  }

  Widget charges(TextStyle? style, String title, double percent) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: style?.copyWith(
              fontSize: 13,
              color: AppColors.g400,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              '$percent% per party',
              style: style?.copyWith(
                fontSize: 13,
                color: AppColors.g400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
