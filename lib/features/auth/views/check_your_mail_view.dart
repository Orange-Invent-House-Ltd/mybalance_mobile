import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:open_mail_app/open_mail_app.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_rich_text.dart';

class CheckYourMailView extends StatelessWidget {
  const CheckYourMailView({
    super.key,
    required this.email,
  });
  final String email;

  void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Open Mail App"),
          content: const Text("No mail apps installed"),
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

  // void _openEmailApp(BuildContext context) async {
  //   var result = await OpenMailApp.openMailApp();

  //   if (!result.didOpen && !result.canOpen) {
  //     showNoMailAppsDialog(context);
  //   } else if (!result.didOpen && result.canOpen) {
  //     showDialog(
  //       context: context,
  //       builder: (_) {
  //         return MailAppPickerDialog(
  //           mailApps: result.options,
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.b300,
        elevation: 0,
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
                    text: email,
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
                onPressed: (){},
                // onPressed: () => _openEmailApp(context),
                child: const Text('Open email app'),
              ),
            ),
            const SizedBox(height: 24),
            AppRichText(
              onSecondaryTap: () {},
              primaryText: 'Didn\'t receive the email?',
              secondaryText: 'Click to resend',
              secondaryColor: AppColors.p300,
            ),
          ],
        ),
      ),
    );
  }
}
