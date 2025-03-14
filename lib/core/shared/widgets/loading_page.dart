import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/themes/app_colors.dart';
import '../../constants/app_assets.dart';
import '../../models/loading_from.dart';
import 'sizedbox.dart';

class LoadingPage extends StatefulWidget {
  final LoadingFrom loadingFrom;
  LoadingPage({
    super.key,
    required String loadFrom,
  }) : loadingFrom = LoadingFrom.fromString(loadFrom);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => switch (widget.loadingFrom) {
                  LoadingFrom.paymentStatus =>
                    const PaymentStatusDialog(paymentSuccess: false),
                  _ => const WithdrawStatusDialog(withdrawSuccess: true),
                });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.w50,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Height(100),
            const Expanded(child: SizedBox()),
            const CupertinoActivityIndicator(
              radius: 20.0,
              color: AppColors.p300,
            ),
            SizedBox(
              height: 24.0.h,
              width: double.infinity,
            ),
            Text(
              'Transaction in progress... Please wait.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.b300),
            ),
            const Expanded(child: SizedBox()),
            Container(
              height: 200.h,
              color: Colors.red,
              child: CustomPaint(
                painter: LoadingBottomPainter(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoadingBottomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = const Color(0xff00C48C);
    final Path path = Path();
    // path.
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaymentStatusDialog extends StatelessWidget {
  const PaymentStatusDialog({
    super.key,
    required this.paymentSuccess,
  });
  final bool paymentSuccess;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 86),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              paymentSuccess
                  ? AppAssets.paymentSuccess
                  : AppAssets.paymentFailed,
            ),
            const Height(16),
            Text(
              paymentSuccess ? 'Payment Successful!' : 'Payment Failed!',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 23.sp,
                color: paymentSuccess ? AppColors.b300 : AppColors.error,
              ),
            ),
            const Height(8),
            Text(
              paymentSuccess
                  ? 'Your payment was transacted successfully! Click the button below to return to MyBalance dashboard.'
                  : 'Unfortunately, your payment was not successful! Click the button below to return to MyBalance dashboard.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                color: AppColors.g500,
              ),
              textAlign: TextAlign.center,
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.pop();
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      paymentSuccess ? AppColors.green : AppColors.error,
                ),
                child: const Text('Return to dashboard'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WithdrawStatusDialog extends StatelessWidget {
  final bool withdrawSuccess;
  const WithdrawStatusDialog({
    super.key,
    required this.withdrawSuccess,
  });

  @override
  Widget build(BuildContext context) {
    const int amount = 2000;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 86),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: withdrawSuccess
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(withdrawSuccess
                  ? AppAssets.unlocked
                  : AppAssets.withdrawFailed),
              const Height(16),
              Text(
                withdrawSuccess
                    ? '$amount Withdrawn! 👍🏾'
                    : 'Cannot Complete Transaction',
                style: textTheme.titleMedium?.copyWith(
                  color: withdrawSuccess ? AppColors.b300 : AppColors.error,
                ),
              ),
              const Height(8),
              Text(
                withdrawSuccess
                    ? 'Weldone! You have successfully withdrawn $amount. You should receive a credit alert in seconds.'
                    : 'Unfortunately, we cannot complete this transaction at this time due to internet issues.',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.g500),
              ),
              const Height(24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (withdrawSuccess) {
                      context.pop();
                      context.pop();
                      context.pop();
                    } else {
                      context.pop();
                      context.pop();
                    }
                  },
                  style: withdrawSuccess
                      ? ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                        )
                      : null,
                  child: Text(
                    withdrawSuccess ? 'Return to dashboard' : 'Try again',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
