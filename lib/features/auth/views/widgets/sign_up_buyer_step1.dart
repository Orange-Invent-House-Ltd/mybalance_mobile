import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/shared/widgets/label_text_field.dart';
import '../../../../core/shared/widgets/sizedbox.dart';

class SignUpBuyerStep1 extends StatelessWidget {
  const SignUpBuyerStep1({
    super.key,
    required this.fullnameController,
    required this.emailController,
  });
  final TextEditingController fullnameController, emailController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        LabelTextField(
          controller: fullnameController,
          label: 'Full name',
          hintText: 'e.g "Albert"',
        ),
        const Height(20),
        LabelTextField(
          controller: emailController,
          validator: Validator.emailValidator,
          label: 'Email',
          hintText: 'alb.ert@gmail.com',
        ),
        const Height(6),
        Text.rich(
          TextSpan(
            text: 'NOTE: ',
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.g200,
            ),
            children: [
              TextSpan(
                text:
                    'Use the email address that was shared with the seller IF ANY.',
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.g200,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
