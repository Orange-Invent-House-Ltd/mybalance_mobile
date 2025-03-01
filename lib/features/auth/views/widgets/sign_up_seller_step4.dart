import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../../../../config/themes/app_colors.dart';

class SignUpSellerStep4 extends StatelessWidget {
  const SignUpSellerStep4({
    super.key,
    required TextEditingController otpNumberController,
    this.pinLength,
  }) : _otpNumberController = otpNumberController;
  final TextEditingController _otpNumberController;
  final int? pinLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44.h,
          child: PinInputTextFormField(
            controller: _otpNumberController,
            pinLength: pinLength ?? 6,
            decoration: BoxLooseDecoration(
              strokeColorBuilder: PinListenColorBuilder(
                AppColors.p300,
                AppColors.b50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
