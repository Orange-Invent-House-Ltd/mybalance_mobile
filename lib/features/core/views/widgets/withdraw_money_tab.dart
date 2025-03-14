import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_name.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/models/loading_from.dart';
import '../../../../core/shared/widgets/label_text_field.dart';
import '../../../../core/shared/widgets/sizedbox.dart';

class WithdrawMoneyTab extends StatefulWidget {
  const WithdrawMoneyTab({super.key});

  @override
  State<WithdrawMoneyTab> createState() => _WithdrawMoneyTabState();
}

class _WithdrawMoneyTabState extends State<WithdrawMoneyTab> {
  late TextEditingController _amountController,
      _reasonController,
      _bankNameController,
      _accountNumberController,
      _accountNameController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _reasonController = TextEditingController();
    _bankNameController = TextEditingController();
    _accountNumberController = TextEditingController();
    _accountNameController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              color: AppColors.g500,
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
            label: 'Reason for withdrawing (Optional)',
            hintText: '****',
            textInputAction: TextInputAction.next,
          ),
          const Height(16),
          Text(
            'RECEIVER ACCOUNT INFORMATION',
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.g500,
            ),
          ),
          const Height(16),
          LabelTextField(
            controller: _bankNameController,
            label: 'Enter a bank name',
            hintText: 'e.g UBA',
            textInputAction: TextInputAction.next,
          ),
          const Height(16),
          LabelTextField(
            controller: _accountNumberController,
            label: 'Enter account number',
            hintText: 'e.g 0099009900',
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
          ),
          const Height(16),
          LabelTextField(
            controller: _accountNameController,
            label: 'Enter account name',
            hintText: 'e.g JamJam',
            textInputAction: TextInputAction.next,
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
                ]),
                builder: (context, child) {
                  return ElevatedButton(
                    onPressed: _amountController.text.isEmpty ||
                            _reasonController.text.isEmpty ||
                            _bankNameController.text.isEmpty ||
                            _accountNumberController.text.isEmpty ||
                            _accountNameController.text.isEmpty
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
    );
  }
}
