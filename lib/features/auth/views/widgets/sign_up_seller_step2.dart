import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/label_text_field.dart';
import '../../../../core/widgets/sizedbox.dart';

class SignUpSellerStep2 extends StatelessWidget {
  const SignUpSellerStep2({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController bankNameController,
    required TextEditingController accountNumberController,
    required TextEditingController accountNameController,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _bankNameController = bankNameController,
        _accountNumberController = accountNumberController,
        _accountNameController = accountNameController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _bankNameController;
  final TextEditingController _accountNumberController;
  final TextEditingController _accountNameController;

  @override
  Widget build(BuildContext context) {
    // _stepperController.animateToPage(
    //   0,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
    // _currentSellerStep.value = 1;
    return Column(
      children: [
        LabelTextField(
          controller: _emailController,
          validator: Validator.emailValidator,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          label: 'Email',
          hintText: 'e.g tmusty@gmail.com',
        ),
        const Height(16.0),
        LabelTextField(
          controller: _passwordController,
          validator: Validator.passwordValidator,
          textInputAction: TextInputAction.next,
          label: 'Password',
          hintText: 'e.g *******',
          obscureText: true,
        ),
        const Height(16.0),
        LabelTextField(
          controller: _bankNameController,
          validator: Validator.nameValidator,
          textInputAction: TextInputAction.next,
          label: 'Bank name',
          hintText: 'e.g “UBA”',
        ),
        const Height(16.0),
        LabelTextField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          label: 'Bank account number',
          hintText: 'e.g 000000000',
        ),
        const Height(16.0),
        LabelTextField(
          controller: _accountNameController,
          validator: Validator.nameValidator,
          textInputAction: TextInputAction.done,
          label: 'Account Name',
          hintText: 'e.g Jamiu Aremu',
        ),
      ],
    );
  }
}
