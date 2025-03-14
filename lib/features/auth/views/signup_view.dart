import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/shared/widgets/app_rich_text.dart';
import '../../../core/shared/widgets/overlay_loading.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import './widgets/is_buyer_view.dart';
import './widgets/is_seller_view.dart';
import './widgets/sell_buy_toggle.dart';
import './widgets/step_progress_indicator.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  late GlobalKey<FormState> _formKey;
  late ValueNotifier<bool> _isBuyer;
  late ValueNotifier<bool> _isSellerStep1;
  late ValueNotifier<int> _currentSellerStep;
  late ValueNotifier<int> _currentBuyerStep;
  final totalSellerSteps = 2;
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
    _isSellerStep1 = ValueNotifier<bool>(true);
    _currentSellerStep = ValueNotifier<int>(1);
    _currentBuyerStep = ValueNotifier<int>(1);
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
    _isSellerStep1.dispose();
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

  // double _calculatePageHeightFactor() {
  //   if (_isBuyer.value) {
  //     if (_currentBuyerStep.value <= 2) {
  //       return .9;
  //     } else {
  //       return .10;
  //     }
  //   } else {
  //     if (_currentSellerStep.value <= 2) {
  //       return .59;
  //     } else if (_currentSellerStep.value == 3) {
  //       if (_meansOfIdController.text.isEmpty) {
  //         return .11;
  //       } else if (_meansOfIdController.text == MeansOfId.nin.label) {
  //         return .23;
  //       } else if (_meansOfIdController.text == MeansOfId.votersCard.label) {
  //         return .70;
  //       } else {
  //         return .33;
  //       }
  //     } else {
  //       return .11;
  //     }
  //   }
  // }

  // void _nextStep() {
  //   if (_currentSellerStep.value < totalSellerSteps) {
  //     _currentSellerStep.value++;
  //     _sellerStepperController.nextPage(
  //       duration: const Duration(milliseconds: 1),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

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
                      width: 50.r,
                      height: 50.r,
                    ),
                  ),
                  const Height(32),
                  SellBuyToggle(
                    onSelect: (value) {
                      _isBuyer.value = value;
                    },
                  ),
                  const Height(32),
                  ListenableBuilder(
                    listenable: Listenable.merge(
                      [_currentSellerStep, _isBuyer],
                    ),
                    builder: (_, __) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _isBuyer.value
                              ? const SizedBox.shrink()
                              // ? StepProgressIndicator(
                              //     currentStep: _currentBuyerStep.value,
                              //     totalSteps: totalBuyerSteps,
                              //   )
                              : StepProgressIndicator(
                                  currentStep: _currentSellerStep.value,
                                  totalSteps: totalSellerSteps,
                                ),
                          Height(
                            _currentSellerStep.value <= 2 ? 0 : 16,
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
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                          const Height(8.0),
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
                          const Height(16),
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
                        // _currentBuyerStep
                      ],
                    ),
                    builder: (context, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1),
                        child: _isBuyer.value
                            ? const IsBuyerView()
                            : _currentSellerStep.value == 1
                                ? IsSellerViewStep1(
                                    onNextPressed: () {
                                      _currentSellerStep.value = 2;
                                    },
                                  )
                                : const IsSellerStep2(),
                      );
                    },
                  ),
                  // const Height(24),
                  SizedBox(
                    width: double.infinity,
                    child: ListenableBuilder(
                      listenable: Listenable.merge(
                        [
                          _isBuyer,
                          _currentSellerStep,
                          // _currentBuyerStep,
                          _meansOfIdController
                        ],
                      ),
                      builder: (context, child) {
                        return const SizedBox.shrink();
                        // return Column(
                        //   children: [
                        //     (!_isBuyer.value &&
                        //             _currentSellerStep.value == 3 &&
                        //             _meansOfIdController.text.isEmpty)
                        //         ? Text.rich(
                        //             TextSpan(
                        //               text: 'Note: ',
                        //               children: [
                        //                 TextSpan(
                        //                   text:
                        //                       'Verify your identity for easy funds withdrawal from escrow.',
                        //                   style: theme.textTheme.bodyMedium
                        //                       ?.copyWith(
                        //                     color: const Color(0xff667085),
                        //                     fontSize: 13.sp,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             style: theme.textTheme.bodyMedium?.copyWith(
                        //               fontWeight: FontWeight.w700,
                        //               color: const Color(0xff667085),
                        //             ),
                        //           )
                        //         : SizedBox(
                        //             width: double.infinity,
                        //             child: ElevatedButton(
                        //               onPressed: () {
                        //                 _nextStep();
                        //               },
                        //               child: Text(
                        //                 _currentSellerStep.value != 4 ||
                        //                         _currentBuyerStep.value != 3
                        //                     ? 'Next'
                        //                     : 'Verify',
                        //               ),
                        //             ),
                        //           ),
                        //     if (!_isBuyer.value &&
                        //         _currentSellerStep.value == 3)
                        //       TextButton(
                        //         onPressed: () {
                        //           _nextStep();
                        //         },
                        //         child: Text(
                        //           'Skip this part',
                        //           style: theme.textTheme.bodyMedium?.copyWith(
                        //             color: AppColors.p300,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         ),
                        //       ),
                        //     if (_currentSellerStep.value == 4 ||
                        //         _currentBuyerStep.value == 3) ...[
                        //       const Height(32),
                        //       AppRichText(
                        //         primaryText: 'Didn\'t receive the email?',
                        //         secondaryText: 'Click to resend',
                        //         onSecondaryTap: () {},
                        //       ),
                        //     ]
                        //   ],
                        // );
                      },
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentSellerStep,
                    child: const Height(32),
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
                          const Height(48)
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
