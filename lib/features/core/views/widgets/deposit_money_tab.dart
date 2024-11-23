import 'package:flutter/material.dart';

import '../../../../core/widgets/label_text_field.dart';
import '../../../../core/widgets/sizedbox.dart';
import '../deposit_money_view.dart';

class DepositMoneyTab extends StatefulWidget {
  const DepositMoneyTab({super.key});

  @override
  State<DepositMoneyTab> createState() => _DepositMoneyTabState();
}

class _DepositMoneyTabState extends State<DepositMoneyTab> {
  late TextEditingController _amountController;
  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextField(
          controller: _amountController,
          label: 'Enter amount to deposit',
          hintText: 'e.g 10,000',
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
        const Height(16),
        SizedBox(
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: _amountController,
            builder: (context, value, child) {
              return ElevatedButton(
                onPressed: value.text.length < 4
                    ? null
                    : () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const DepositTransferDialog();
                          },
                        );
                      },
                child: const Text('Continue'),
              );
            },
          ),
        ),
      ],
    );
  }
}
