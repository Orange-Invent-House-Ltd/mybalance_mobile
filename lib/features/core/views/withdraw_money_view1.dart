import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mybalanceapp/core/widgets/label_text_field.dart';

import '../../../config/routes/route_name.dart';
import '../../../config/themes/app_colors.dart';
import '../../../core/models/loading_from.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/sizedbox.dart';

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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Withdraw Money',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * .85,
              child: Text(
                'In a case of a dispute with a seller, you can choose to withdraw your money back.',
                style:
                    theme.textTheme.bodyMedium?.copyWith(color: AppColors.g500),
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
                      onPressed: _amountController.text.isEmpty ||
                              _reasonController.text.isEmpty ||
                              _bankNameController.text.isEmpty ||
                              _accountNumberController.text.isEmpty ||
                              _accountNameController.text.isEmpty ||
                              _emailController.text.isEmpty
                          ? null
                          : () {
                              context.pushNamed(
                                RouteName.loading,
                                queryParameters: <String, String>{
                                  'loadingFrom': LoadingFrom.withdrawMoney.name,
                                },
                              );
                            },
                      child: const Text('Withdraw amount'),
                    );
                  }),
            ),
            const Height(84),
          ],
        ),
      ),
    );
  }
}
