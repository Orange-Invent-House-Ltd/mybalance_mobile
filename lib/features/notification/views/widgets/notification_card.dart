import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/shared/widgets/sizedbox.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.isRead,
    required this.timestamp,
  });
  final String title;
  final String description;
  final bool isRead;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: SizedBox(
            width: 10.w,
            height: 10.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isRead ? const Color(0xffE4E4E4) : AppColors.p300,
              ),
            ),
          ),
        ),
        const Width(16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have locked 10,000',
              style:
                  theme.textTheme.titleMedium?.copyWith(color: AppColors.b300),
            ),
            const Height(6),
            SizedBox(
              width: size.width * 0.70,
              child: Text(
                'For White pair of Air Jordans For White pair of Air Jordans For White pair of Air Jordans ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  color: AppColors.g300,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Height(6),
            Text(
              FormatDate.timeAgo(timestamp),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10.sp,
                color: AppColors.g75,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
