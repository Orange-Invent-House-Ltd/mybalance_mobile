import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './sizedbox.dart';
import 'package:go_router/go_router.dart';
import '../../config/themes/app_colors.dart';
import '../constants/app_assets.dart';

class PaymentLoadingPage extends StatefulWidget {
  const PaymentLoadingPage({super.key});

  @override
  State<PaymentLoadingPage> createState() => _PaymentLoadingPageState();
}

class _PaymentLoadingPageState extends State<PaymentLoadingPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const PaymentStatusDialog(
            paymentSuccess: false,
          ),
        );
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
            const SizedBox(height: 100),
            const Expanded(child: SizedBox()),
            const CupertinoActivityIndicator(
              radius: 20.0,
              color: AppColors.p300,
            ),
            const SizedBox(
              height: 24.0,
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
              height: 200,
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
                fontSize: 23,
                color: paymentSuccess ? AppColors.b300 : AppColors.error,
              ),
            ),
            const Height(8),
            Text(
              paymentSuccess
                  ? 'Your payment was transacted successfully! Click the button below to return to MyBalance dashboard.'
                  : 'Unfortunately, your payment was not successful! Click the button below to return to MyBalance dashboard.',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13,
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
                    backgroundColor: paymentSuccess
                        ? const Color(0xff039855)
                        : AppColors.error),
                child: const Text('Return to dashboard'),
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
