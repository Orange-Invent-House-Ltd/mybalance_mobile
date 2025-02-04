import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../config/themes/app_colors.dart';
import '../../core/constants/app_assets.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: ElevatedButton(
        onPressed: context.pop,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(2),
          backgroundColor: AppColors.p50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: SvgPicture.asset(AppAssets.backArrow),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(2),
    //   decoration: BoxDecoration(
    //     color: AppColors.p50,
    //     borderRadius: BorderRadius.circular(6),
    //   ),
    //   child: SvgPicture.asset(AppAssets.backArrow),
    // );
  }
}
