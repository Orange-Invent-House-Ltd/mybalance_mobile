import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/label_text_field.dart';
import '../../../../core/widgets/sizedbox.dart';

class IsBuyerView extends StatefulWidget {
  const IsBuyerView({super.key});

  @override
  State<IsBuyerView> createState() => _IsBuyerViewState();
}

class _IsBuyerViewState extends State<IsBuyerView> {
  late ValueNotifier<bool> _passwordVisible;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstNameController,
      _lastNameController,
      _emailController,
      _phoneController,
      _passwordController,
      _referralController;

  @override
  void initState() {
    super.initState();
    _passwordVisible = ValueNotifier<bool>(false);
    _formKey = GlobalKey<FormState>();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _referralController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordVisible.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(
            controller: _firstNameController,
            validator: Validator.nameValidator,
            label: 'First name',
            hintText: 'e.g "Albert"',
          ),
          const Height(20),
          LabelTextField(
            controller: _firstNameController,
            validator: Validator.nameValidator,
            label: 'Last name',
            hintText: 'e.g "Albert"',
          ),
          const Height(20),
          LabelTextField(
            controller: _emailController,
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
          const Height(20),
          LabelTextField(
            controller: _phoneController,
            validator: Validator.phoneValidator,
            label: 'Phone',
            hintText: 'e.g "08155667788"',
          ),
          const Height(20),
          ValueListenableBuilder(
              valueListenable: _passwordVisible,
              builder: (context, value, child) {
                return LabelTextField(
                  controller: _passwordController,
                  validator: Validator.nameValidator,
                  obscureText: !value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      value ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.g200,
                    ),
                    onPressed: () {
                      _passwordVisible.value = !_passwordVisible.value;
                    },
                  ),
                  label: 'Password',
                  hintText: '**********',
                );
              }),
          const Height(20),
          LabelTextField(
            controller: _referralController,
            label: 'Where did you hear about us?',
            hintText: 'Select location',
            readOnly: true,
            onTap: () {},
          ),
          const Height(24),
          FullWidth(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
