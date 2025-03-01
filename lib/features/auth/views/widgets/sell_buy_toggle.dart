import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/app_colors.dart';

class SellBuyToggle extends StatefulWidget {
  const SellBuyToggle({
    super.key,
    required this.onSelect,
  });
  final Function(bool) onSelect;

  @override
  State<SellBuyToggle> createState() => _SellBuyToggleState();
}

class _SellBuyToggleState extends State<SellBuyToggle> {
  bool isBuyer = false;
  void _onSelected(bool value) {
    setState(() {
      isBuyer = value;
    });
    widget.onSelect(value);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => _onSelected(true),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isBuyer ? AppColors.p50 : null,
              border: Border(
                bottom: BorderSide(
                  width: isBuyer ? 2.w : 1.w,
                  color: isBuyer ? AppColors.p500 : AppColors.g200,
                ),
              ),
            ),
            child: Text(
              'Is buyer',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isBuyer ? AppColors.p500 : AppColors.g200,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _onSelected(false),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: !isBuyer ? AppColors.p50 : null,
              border: Border(
                bottom: BorderSide(
                  width: !isBuyer ? 2.w : 1.w,
                  color: !isBuyer ? AppColors.p500 : AppColors.g200,
                ),
              ),
            ),
            child: Text(
              'Is seller',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: !isBuyer ? AppColors.p500 : AppColors.g200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
