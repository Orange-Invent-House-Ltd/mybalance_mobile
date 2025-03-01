import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/transaction_status.dart';

class StatusTooltip extends StatelessWidget {
  const StatusTooltip({super.key, required this.status});
  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.name,
        style: textTheme.labelSmall?.copyWith(
          fontSize: 10.sp,
          color: status.foregroundColor,
        ),
      ),
    );
  }
}
