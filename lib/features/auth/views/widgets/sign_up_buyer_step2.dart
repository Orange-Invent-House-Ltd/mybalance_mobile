import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/shared/widgets/label_text_field.dart';
import '../../../../core/shared/widgets/sizedbox.dart';

class SignUpBuyerStep2 extends StatelessWidget {
  const SignUpBuyerStep2({
    super.key,
    required TextEditingController phoneController,
    required TextEditingController passwordController,
  })  : _phoneController = phoneController,
        _passwordController = passwordController;
  final TextEditingController _phoneController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelTextField(
          controller: _phoneController,
          label: 'Phone number',
          hintText: '+234 000 0000 000',
        ),
        const Height(20),
        LabelTextField(
          controller: _passwordController,
          validator: Validator.passwordValidator,
          label: 'Password',
          hintText: '**************',
          obscureText: true,
        ),
      ],
    );
  }
}
