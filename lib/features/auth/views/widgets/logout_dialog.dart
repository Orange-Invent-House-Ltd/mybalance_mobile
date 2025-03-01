import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/sizedbox.dart';
import '../providers/provider.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      // insetPadding:
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppAssets.errorInfo),
            const Height(16),
            Text(
              'Logout!',
              style: textTheme.titleMedium!.copyWith(
                color: const Color(0xff101828),
              ),
            ),
            const Height(8),
            Text(
              'Are you sure you want to logout?',
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                color: AppColors.g500,
              ),
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: Navigator.of(context).pop,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: AppColors.g75,
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: textTheme.titleMedium?.copyWith(color: AppColors.g500),
                ),
              ),
            ),
            const Height(12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(authProvider.notifier).signOut();
                },
                child: Text(
                  'Logout',
                  style: textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
