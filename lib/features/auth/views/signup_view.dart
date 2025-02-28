import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_rich_text.dart';
import '../../../core/widgets/overlay_loading.dart';
import '../../../core/widgets/sizedbox.dart';
import '../models/means_of_id.dart';
import './widgets/sell_buy_toggle.dart';
import './widgets/sign_up_buyer_step1.dart';
import './widgets/sign_up_buyer_step2.dart';
import './widgets/sign_up_seller_step1.dart';
import './widgets/sign_up_seller_step2.dart';
import './widgets/sign_up_seller_step3.dart';
import './widgets/sign_up_seller_step4.dart';
import './widgets/step_progress_indicator.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<bool> _isBuyer;
  late ValueNotifier<int> _currentSellerStep;
  late ValueNotifier<int> _currentBuyerStep;
  final totalSellerSteps = 4;
  final totalBuyerSteps = 3;
  late PageStorageKey<String> _buyerKey;
  late PageStorageKey<String> _sellerKey;
  late PageController _sellerStepperController, _buyerStepperController;
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
      _meansOfIdController,
      _otpNumberController;

  @override
  initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _isBuyer = ValueNotifier<bool>(true);
    _currentSellerStep = ValueNotifier<int>(1);
    _currentBuyerStep = ValueNotifier<int>(1);
    _buyerKey = const PageStorageKey<String>('buyer');
    _sellerKey = const PageStorageKey<String>('seller');
    _sellerStepperController = PageController();
    _buyerStepperController = PageController();
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
    _otpNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _isBuyer.dispose();
    _currentSellerStep.dispose();
    _currentBuyerStep.dispose();
    _sellerStepperController.dispose();
    _buyerStepperController.dispose();
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
    _otpNumberController.dispose();
    super.dispose();
  }

  double _calculatePageHeightFactor() {
    if (_isBuyer.value) {
      if (_currentBuyerStep.value <= 2) {
        return .26;
      } else {
        return .10;
      }
    } else {
      if (_currentSellerStep.value <= 2) {
        return .54;
      } else if (_currentSellerStep.value == 3) {
        if (_meansOfIdController.text.isEmpty) {
          return .11;
        } else if (_meansOfIdController.text == MeansOfId.nin.label) {
          return .23;
        } else if (_meansOfIdController.text == MeansOfId.votersCard.label) {
          return .70;
        } else {
          return .33;
        }
      } else {
        return .11;
      }
    }
  }

  void _nextStep() {
    if (_isBuyer.value) {
      if (_currentBuyerStep.value < totalBuyerSteps) {
        _currentBuyerStep.value++;
        _buyerStepperController.nextPage(
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
      }
    } else {
      if (_currentSellerStep.value < totalSellerSteps) {
        _currentSellerStep.value++;
        _sellerStepperController.nextPage(
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  String _title() {
    if (_currentBuyerStep.value <= 2 || _currentSellerStep.value <= 2) {
      return 'Create your account now';
    } else if (_currentSellerStep.value == 3 && !_isBuyer.value) {
      return 'We need your identity';
    } else {
      return 'Check your email';
    }
  }

  bool _titleAlign() {
    if (_isBuyer.value) {
      if (_currentBuyerStep.value <= 2) {
        return false;
      }
      return true;
    } else {
      if (_currentSellerStep.value <= 2) {
        return false;
      }
      return true;
    }
  }

  String _subTitle(String email) {
    if (_isBuyer.value) {
      if (_currentBuyerStep.value == 1 || _currentBuyerStep.value == 2) {
        return 'Create your customer account in minutes and enjoy the full features of MyBalance';
      } else {
        return 'We sent a verification link to $email';
      }
    } else {
      if (_currentSellerStep.value == 1 || _currentSellerStep.value == 2) {
        return 'Create your seller account in minutes and enjoy the full features of MyBalance';
      } else if (_currentSellerStep.value == 3) {
        return 'Choose your means of identity.';
      }
      return 'We sent a verification link to $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: OverlayLoading(
          isLoading: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const Height( 32),
                  SellBuyToggle(
                    onSelect: (value) {
                      _isBuyer.value = value;
                    },
                  ),
                  const Height( 32),
                  ListenableBuilder(
                    listenable: Listenable.merge(
                      [_currentSellerStep, _currentBuyerStep, _isBuyer],
                    ),
                    builder: (_, __) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _isBuyer.value
                              ? StepProgressIndicator(
                                  currentStep: _currentBuyerStep.value,
                                  totalSteps: totalBuyerSteps,
                                )
                              : StepProgressIndicator(
                                  currentStep: _currentSellerStep.value,
                                  totalSteps: totalSellerSteps,
                                ),
                          Height( _currentSellerStep.value <= 2 ? 0 : 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              _title(),
                              textAlign: _titleAlign()
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: AppColors.b300,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const Height( 8.0),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              _subTitle(_emailController.text),
                              textAlign: _titleAlign()
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.g200),
                            ),
                          ),
                          const Height( 16),
                        ],
                      );
                    },
                  ),
                  ListenableBuilder(
                    listenable: Listenable.merge(
                      [
                        _meansOfIdController,
                        _isBuyer,
                        _currentSellerStep,
                        _currentBuyerStep
                      ],
                    ),
                    builder: (context, child) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 1),
                        height: size.height * _calculatePageHeightFactor(),
                        // height: size.height * 0.85,
                        // child: AnimatedSwitcher(duration: Duration(milliseconds: 1)),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1),
                          child: _isBuyer.value
                              ? PageView(
                                  key: _buyerKey,
                                  controller: _buyerStepperController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    SignUpBuyerStep1(
                                      fullnameController: _fullnameController,
                                      emailController: _emailController,
                                    ),
                                    SignUpBuyerStep2(
                                      phoneController: _phoneController,
                                      passwordController: _passwordController,
                                    ),
                                    SignUpSellerStep4(
                                      otpNumberController: _otpNumberController,
                                    ),
                                  ],
                                )
                              : PageView(
                                  key: _sellerKey,
                                  controller: _sellerStepperController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    SignUpSellerStep1(
                                      fullnameController: _fullnameController,
                                      businessNameController:
                                          _businessNameController,
                                      serviceController: _serviceController,
                                      addressController: _addressController,
                                      phoneController: _phoneController,
                                    ),
                                    SignUpSellerStep2(
                                      emailController: _emailController,
                                      passwordController: _passwordController,
                                      bankNameController: _bankNameController,
                                      accountNumberController:
                                          _accountNumberController,
                                      accountNameController:
                                          _accountNameController,
                                    ),
                                    SignUpSellerStep3(
                                      meansOfIdController: _meansOfIdController,
                                    ),
                                    SignUpSellerStep4(
                                      otpNumberController: _otpNumberController,
                                    ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                  const Height( 24),
                  SizedBox(
                    width: double.infinity,
                    child: ListenableBuilder(
                      listenable: Listenable.merge(
                        [
                          _isBuyer,
                          _currentSellerStep,
                          _currentBuyerStep,
                          _meansOfIdController
                        ],
                      ),
                      builder: (context, child) {
                        return Column(
                          children: [
                            (!_isBuyer.value &&
                                    _currentSellerStep.value == 3 &&
                                    _meansOfIdController.text.isEmpty)
                                ? Text.rich(
                                    TextSpan(
                                      text: 'Note: ',
                                      children: [
                                        TextSpan(
                                          text:
                                              'Verify your identity for easy funds withdrawal from escrow.',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
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
                                : SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _nextStep();
                                      },
                                      child: Text(
                                        _currentSellerStep.value != 4 ||
                                                _currentBuyerStep.value != 3
                                            ? 'Next'
                                            : 'Verify',
                                      ),
                                    ),
                                  ),
                            if (!_isBuyer.value &&
                                _currentSellerStep.value == 3)
                              TextButton(
                                onPressed: () {
                                  _nextStep();
                                },
                                child: Text(
                                  'Skip this part',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppColors.p300,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            if (_currentSellerStep.value == 4 ||
                                _currentBuyerStep.value == 3) ...[
                              const Height( 32),
                              AppRichText(
                                primaryText: 'Didn\'t receive the email?',
                                secondaryText: 'Click to resend',
                                onSecondaryTap: () {},
                              ),
                            ]
                          ],
                        );
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentSellerStep,
                    child: const Height( 32),
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          if (value <= 2) ...[
                            child!,
                            SizedBox(
                              width: double.infinity,
                              child: AppRichText(
                                onSecondaryTap: () =>
                                    context.goNamed(RouteName.signIn),
                                primaryText: 'Existing user?',
                                secondaryText: 'Log in here',
                              ),
                            ),
                          ],
                          child!,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
