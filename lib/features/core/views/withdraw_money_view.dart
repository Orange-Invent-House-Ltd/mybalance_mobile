import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/core/constants/app_assets.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/overlay_loading.dart';
import '../../../core/shared/widgets/sizedbox.dart';

class WithdrawMoneyView extends StatefulWidget {
  const WithdrawMoneyView({super.key});

  @override
  State<WithdrawMoneyView> createState() => _WithdrawMoneyViewState();
}

class _WithdrawMoneyViewState extends State<WithdrawMoneyView> {
  late TextEditingController _amountController,
      _reasonController,
      _bankNameController,
      _accountNumberController,
      _accountNameController,
      _emailController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _reasonController = TextEditingController();
    _bankNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return OverlayLoading(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: CustomAppBar(
          theme: theme,
          text: 'Withdraw Funds',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'After your transaction with a buyer is successful, withdraw your funds with the form below.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.g500,
                ),
              ),
              const Height(40),
              Text(
                'SENDER ADDITIONAL INFORMATION',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
              LabelTextField(
                controller: _amountController,
                label: 'How much are you withdrawing?',
                hintText: '20,000',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _reasonController,
                label: 'Reason for withdrawing (description)',
                hintText: '****',
                textInputAction: TextInputAction.next,
              ),
              const Height(24),
              Text(
                'BANK INFORMATION',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
              LabelTextField(
                controller: _bankNameController,
                label: 'Select bank',
                hintText: 'e.g UBA',
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _accountNumberController,
                label: 'Enter account number',
                hintText: '****',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _accountNameController,
                label: 'Select account name',
                hintText: 'e.g JamJam',
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _emailController,
                label: 'Email address',
                hintText: 'Mustyfeet@gmail.com',
                textInputAction: TextInputAction.done,
              ),
              const Height(24),
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                    listenable: Listenable.merge([
                      _amountController,
                      _reasonController,
                      _bankNameController,
                      _accountNumberController,
                      _accountNameController,
                      _emailController,
                    ]),
                    builder: (context, child) {
                      return ElevatedButton(
                        // onPressed: _amountController.text.isEmpty ||
                        //         _reasonController.text.isEmpty ||
                        //         _bankNameController.text.isEmpty ||
                        //         _accountNumberController.text.isEmpty ||
                        //         _accountNameController.text.isEmpty ||
                        //         _emailController.text.isEmpty
                        //     ? null
                        //     : () {
                        //         context.pushNamed(RouteName.loading);
                        //       },
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => const WithdrawFundError(),
                            // const WithdrawFundSuccess(amount: 20000),
                          );
                          // setState(() {
                          //   _isLoading = !_isLoading;
                          // });
                          // context.goNamed(RouteName.loading);
                        },
                        child: const Text('Withdraw amount'),
                      );
                    }),
              ),
              const Height(84),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawFundError extends StatelessWidget {
  const WithdrawFundError({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.errorInfo),
                const Height(16),
                Text(
                  'Cannot Complete Transaction',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.error),
                ),
                const Height(8),
                Text(
                  'Unfortunately, we cannot complete this transaction at this time due to internet issues.',
                  // textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.g500),
                ),
                const Height(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.pushReplacementNamed(RouteName.dashboard),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                    ),
                    child: const Text('Try again'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WithdrawFundSuccess extends StatelessWidget {
  const WithdrawFundSuccess({super.key, required this.amount});
  final double amount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(AppAssets.successMarkGreen),
                const Height(16),
                Text(
                  '$amount Withdrawn! 👍🏾',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.b300),
                ),
                const Height(8),
                Text(
                  'Weldone! You have successfully withdrawn $amount. You should receive a credit alert in seconds.',
                  // textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.g500),
                ),
                const Height(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.pushReplacementNamed(RouteName.dashboard),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                    ),
                    child: const Text('Return to dashboard'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
