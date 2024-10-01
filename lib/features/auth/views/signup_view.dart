import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/widgets/app_rich_text.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/custom_dropdown.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/overlay_loading.dart';
import '../models/means_of_id.dart';
import './widgets/sell_buy_toggle.dart';
import './widgets/step_progress_indicator.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<bool> _isBuyer;
  late ValueNotifier<int> _currentStep;
  final totalSteps = 4;
  late PageController _stepperController;
  late TextEditingController _fullnameController,
      _businessNameController,
      _serviceController,
      _addressController,
      _phoneController,
      _emailController,
      _passwordController,
      _bankNameController,
      _accountNumberController,
      _accountNameController,
      _meansOfIdController;

  @override
  initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isBuyer = ValueNotifier(false);
    _currentStep = ValueNotifier(1);
    _stepperController = PageController();
    _fullnameController = TextEditingController();
    _businessNameController = TextEditingController();
    _serviceController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _bankNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();
    _meansOfIdController = TextEditingController();
  }

  @override
  void dispose() {
    _isBuyer.dispose();
    _currentStep.dispose();
    _stepperController.dispose();
    _fullnameController.dispose();
    _businessNameController.dispose();
    _serviceController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    _meansOfIdController.dispose();
    super.dispose();
  }

  int buildNo = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    log('Build called: $buildNo');
    buildNo += 1;

    return Scaffold(
      body: SafeArea(
        child: OverlayLoading(
          isLoading: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppAssets.logo,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SellBuyToggle(
                    onSelect: (value) {
                      _isBuyer.value = value;
                    },
                  ),
                  const SizedBox(height: 32),
                  ValueListenableBuilder(
                    valueListenable: _currentStep,
                    builder: (_, value, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: value <= 2
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          StepProgressIndicator(
                            currentStep: value,
                            totalSteps: totalSteps,
                          ),
                          Text(
                            value == 1 || value == 2
                                ? 'Create your account now'
                                : value == 3
                                    ? 'We need your identity'
                                    : 'Check your email',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppColors.b300,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          if (value <= 2) child!,
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                    child: ValueListenableBuilder(
                      valueListenable: _isBuyer,
                      builder: (context, value, child) {
                        return Text(
                          'Create your ${value ? 'buyer' : 'seller'} account in minutes and enjoy the full features of MyBalance',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: AppColors.g200),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.55,
                    child: PageView(
                      controller: _stepperController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildStep1(),
                        _buildStep2(),
                        SignUpStep3(
                          meansOfIdController: _meansOfIdController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ListenableBuilder(
                      listenable: Listenable.merge(
                        [_stepperController, _meansOfIdController],
                      ),
                      builder: (context, child) {
                        // return _currentStep.value == 3 &&
                        // _meansOfIdController.text.isNotEmpty
                        return ElevatedButton(
                          onPressed: () {
                            if (_currentStep.value < totalSteps) {
                              _currentStep.value++;
                              _stepperController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          child: const Text('Next'),
                        );
                        // : const SizedBox.shrink();
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 32,
                    width: double.infinity,
                    child: AppRichText(
                      onSecondaryTap: () {},
                      primaryText: 'Existing user?',
                      secondaryText: 'Log in here',
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        LabelTextField(
          controller: _fullnameController,
          label: 'Full name',
          hintText: 'e.g "Aremu Jamiu"',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _businessNameController,
          label: 'Business name',
          hintText: 'e.g “Musty Feet”',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _serviceController,
          label: 'Describe your service',
          hintText: 'e.g Sales of footwear',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _addressController,
          label: 'Address',
          hintText: 'Ikeja, Lagos.',
        ),
        const SizedBox(height: 16),
        LabelTextField(
          controller: _phoneController,
          label: 'Phone number',
          hintText: '+234 000 0000 000',
        ),
      ],
    );
  }

  Widget _buildStep2() {
    // _stepperController.animateToPage(
    //   0,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeInOut,
    // );
    // _currentStep.value = 1;
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
        const SizedBox(height: 16.0),
        LabelTextField(
          controller: _passwordController,
          validator: Validator.passwordValidator,
          textInputAction: TextInputAction.next,
          label: 'Password',
          hintText: 'e.g *******',
          obscureText: true,
        ),
        const SizedBox(height: 16.0),
        LabelTextField(
          controller: _bankNameController,
          validator: Validator.nameValidator,
          textInputAction: TextInputAction.next,
          label: 'Bank name',
          hintText: 'e.g “UBA”',
        ),
        const SizedBox(height: 16.0),
        LabelTextField(
          controller: _accountNumberController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          label: 'Bank account number',
          hintText: 'e.g 000000000',
        ),
        const SizedBox(height: 16.0),
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

class SignUpStep3 extends StatelessWidget {
  const SignUpStep3({
    super.key,
    required this.meansOfIdController,
  });
  final TextEditingController meansOfIdController;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        CustomDropdown(
          textController: meansOfIdController,
          label: 'Means of ID',
          hintText: 'Select means of ID',
          items: MeansOfId.values.map((MeansOfId id) {
            return CustomDropdownEntry(
              id.name,
              id.label,
            );
          }).toList(),
        ),
        const SizedBox(height: 32),
        TextButton(
          onPressed: () {},
          child: Text(
            'Skip this part',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.p300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text.rich(
          TextSpan(
            text: 'Note: ',
            children: [
              TextSpan(
                text:
                    'Verify your identity for easy funds withdrawal from escrow.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xff667085),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xff667085),
          ),
        )
      ],
    );
  }
}
