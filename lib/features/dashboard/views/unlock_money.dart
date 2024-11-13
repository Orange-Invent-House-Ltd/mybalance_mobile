import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/sizedbox.dart';

class UnlockMoneyView extends StatefulWidget {
  const UnlockMoneyView({super.key});

  @override
  State<UnlockMoneyView> createState() => _UnlockMoneyViewState();
}

class _UnlockMoneyViewState extends State<UnlockMoneyView> {
  late TextEditingController _titleController,
      _descriptionController,
      _noOfItemController,
      _amountController,
      _deliveryTimeController,
      _emailController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _noOfItemController = TextEditingController();
    _amountController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _noOfItemController.dispose();
    _amountController.dispose();
    _deliveryTimeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Unlock Money',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'After receiving your item and you are satisfied with it, you can proceed to unlock the money.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.g500,
              ),
            ),
            const Height(40),
            Text(
              'RECEIVER ACCOUNT INFORMATION',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.g50,
              ),
            ),
            const Height(24),
            LabelTextField(
              controller: _titleController,
              label: 'Title',
              hintText: 'Purchase of sneakers',
                textInputAction: TextInputAction.next,
            ),
            const Height(16),
            LabelTextField(
              controller: _descriptionController,
              label: 'Description',
              hintText: 'Nike sneakers',
                textInputAction: TextInputAction.next,
            ),
            const Height(16),
            LabelTextField(
              controller: _noOfItemController,
              label: 'Number of item(s)',
                hintText: '1',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
            ),
            const Height(16),
            LabelTextField(
              controller: _amountController,
              label: 'Amount',
            ),
            const Height(16),
            LabelTextField(
              controller: _deliveryTimeController,
              label: 'Delivery timeline',
            ),
            const Height(24),
            Text(
              'RECEIVER ACCOUNT INFORMATION',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.g50,
              ),
            ),
            const Height(16),
            LabelTextField(
              controller: _emailController,
              label: 'Email address',
              hintText: 'Mustyfeet@gmail.com',
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Report a dispute'),
              ),
            ),
            const Height(24),
            SizedBox(
              width: double.infinity,
              child: ListenableBuilder(
                  listenable: Listenable.merge([
                    _titleController,
                    _descriptionController,
                    _noOfItemController,
                    _amountController,
                    _deliveryTimeController,
                    _emailController,
                  ]),
                  builder: (context, child) {
                    return ElevatedButton(
                      onPressed: _titleController.text.isEmpty ||
                              _descriptionController.text.isEmpty ||
                              _noOfItemController.text.isEmpty ||
                              _amountController.text.isEmpty ||
                              _deliveryTimeController.text.isEmpty
                          ? null
                          : () {},
                      child: const Text('Unlock amount'),
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
