import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_name.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/sizedbox.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                fontSize: 14,
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
                  // Add logout logic here
                  Navigator.of(context).pop();
                  context.goNamed(RouteName.signIn);
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
