import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/dispute_resolution_status.dart';

class DisputeStatusTooltip extends StatelessWidget {
  const DisputeStatusTooltip({
    super.key,
    required this.status,
  });

  final DisputeResolutionStatus status;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: status.backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 8,
        ),
        child: Text(
          status.name,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 15.sp,
            color: status.foregroundColor,
          ),
        ),
      ),
    );
  }
}
