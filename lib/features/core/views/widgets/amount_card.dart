import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/extensions/num_extension.dart';

class AmountCard extends StatelessWidget {
  const AmountCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isLoading,
  });
  final String title;
  final double amount;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: 270.w,
      height: 94.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.p500),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: SvgPicture.asset(AppAssets.accountArc),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
              ),
              child: SvgPicture.asset(AppAssets.smallAccountArc),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.g500,
                  ),
                ),
                Text(
                  isLoading ? '...' : amount.toCurrency(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.g500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.error
      ..style = PaintingStyle.fill
      ..strokeWidth = 5.0;

    final rect = Rect.fromLTWH(-16, -16, size.width * .20, size.height);
    canvas.drawArc(rect, 3.14, 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
