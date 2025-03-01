import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/core/constants/app_assets.dart';
import 'package:mybalanceapp/core/widgets/sizedbox.dart';

import '../../../../config/themes/app_colors.dart';

class UnlockFundDialog extends StatelessWidget {
  const UnlockFundDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 4,
        color: AppColors.w50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unlock Funds!',
                style: textTheme.titleMedium?.copyWith(color: AppColors.b300),
              ),
              const Height(8),
              Text(
                'Before proceeding, please confirm if you wish to unlock the funds for this transaction.',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.g500),
              ),
              const Height(24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: Navigator.of(context).pop,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.g50),
                    foregroundColor: AppColors.g500,
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const Height(8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => const NewAmountUnlockedDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                  ),
                  child: const Text('Proceed'),
                ),
              ),
              const Height(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Text.rich(
                  TextSpan(
                    text:
                        'By unlocking the funds, you are accepting responsibility for verifying the quality of the received product. For more details on your buyer obligations, we recommend reviewing our ',
                    children: [
                      TextSpan(
                        text: '“Terms and Conditions”',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.p200,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 10.sp,
                    color: AppColors.g300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewAmountUnlockedDialog extends StatelessWidget {
  const NewAmountUnlockedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 120),
      alignment: Alignment.bottomCenter,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 4,
        color: AppColors.w50,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(AppAssets.unlocked),
              const Height(16),
              Text(
                'New Amount Unlocked! 👍🏾',
                style: textTheme.titleMedium?.copyWith(color: AppColors.b300),
              ),
              const Height(8),
              Text.rich(
                TextSpan(
                  text:
                      'Weldone! You have successfully unlocked [amount]. It will reflect as ',
                  children: [
                    TextSpan(
                      text: 'Fulfilled',
                      style:
                          textTheme.labelLarge?.copyWith(color: AppColors.g500),
                    ),
                    const TextSpan(
                      text: ' in your transaction history and escrow.',
                    ),
                  ],
                ),
                style: textTheme.bodyMedium?.copyWith(color: AppColors.g500),
              ),
              const Height(24),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: Navigator.of(context).pop,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.g50),
                    foregroundColor: AppColors.g500,
                  ),
                  child: const Text('Unlock another amount'),
                ),
              ),
              const Height(8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.pop();
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green,
                  ),
                  child: const Text('Return to dashboard'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
