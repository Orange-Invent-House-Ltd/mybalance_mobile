import 'package:flutter/material.dart';
import 'package:mybalanceapp/config/themes/app_colors.dart';
import 'package:mybalanceapp/core/utils/extensions/num_extension.dart';

class AmountCard extends StatelessWidget {
  const AmountCard({
    super.key,
    required this.title,
    required this.amount,
  });
  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 110,
      height: 94,
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.g50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: AppColors.g500,
            ),
          ),
          Text(
            amount.toCurrency(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.g500,
            ),
          ),
        ],
      ),
    );
  }
}
