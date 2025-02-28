import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_rich_text.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'providers/provider.dart';

class CheckYourMailView extends ConsumerStatefulWidget {
  const CheckYourMailView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  ConsumerState<CheckYourMailView> createState() => _CheckYourMailViewState();
}

class _CheckYourMailViewState extends ConsumerState<CheckYourMailView> {
  final ValueNotifier<bool> canResendNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<int> countdownNotifier = ValueNotifier<int>(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startResendCooldown();
  }

  void startResendCooldown() {
    canResendNotifier.value = false;
    countdownNotifier.value = 300; // 5 minutes (in seconds)

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownNotifier.value > 0) {
        countdownNotifier.value--;
      } else {
        canResendNotifier.value = true;
        timer.cancel();
      }
    });
  }

  void resendEmail() {
    if (canResendNotifier.value) {
      log("Resending email to ${widget.email}");
      ref.read(authProvider.notifier).forgetPassword(widget.email);
      startResendCooldown();
    }
  }

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("Could not open email app."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _openEmailApp(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.email,
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      if (context.mounted) showNoMailAppsDialog(context);
    }
  }

  String formatCountdown(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    canResendNotifier.dispose();
    countdownNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.logo,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 64),
            Text(
              'Check your email',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.b300,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'We sent a password reset link to ',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.g200,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: widget.email,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.g200,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 44,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _openEmailApp(context);
                },
                // onPressed: () => _openEmailApp(context),
                child: const Text('Open email app'),
              ),
            ),
            const SizedBox(height: 24),
            ListenableBuilder(
              listenable:
                  Listenable.merge([canResendNotifier, countdownNotifier]),
              builder: (context, child) {
                return AppRichText(
                  onSecondaryTap:
                      canResendNotifier.value ? () => resendEmail() : null,
                  primaryText: 'Didn\'t receive the email?',
                  secondaryText: canResendNotifier.value
                      ? "Click to resend"
                      : "Resend available in ${formatCountdown(countdownNotifier.value)}",
                  secondaryColor:
                      canResendNotifier.value ? AppColors.p300 : AppColors.g100,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
