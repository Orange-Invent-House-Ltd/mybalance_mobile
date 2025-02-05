import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/sizedbox.dart';
import '../models/transaction_model.dart';

class ViewTransDetail extends StatefulWidget {
  const ViewTransDetail({super.key, required this.id});
  final String id;

  @override
  State<ViewTransDetail> createState() => _ViewTransDetailState();
}

class _ViewTransDetailState extends State<ViewTransDetail> {
  late TextEditingController _titleController,
      _descriptionController,
      _noOfItemsController,
      _amountController,
      _deliveryTimeController,
      _emailController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _noOfItemsController = TextEditingController();
    _amountController = TextEditingController();
    _deliveryTimeController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _noOfItemsController.dispose();
    _amountController.dispose();
    _deliveryTimeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Transactions get transaction => trans.firstWhere((t) => t.id == widget.id);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'View Transaction Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StatusTooltip(
            //   status: 'Pending',
            // ),
            const Height(12),
            Text(
              'ITEM(S) INFORMATION',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                color: AppColors.g50,
              ),
            ),
            const Height(8),
            LabelTextField(
              controller: _titleController,
              readOnly: true,
              label: 'Title',
              hintText: transaction.title,
            ),
            const Height(16),
            LabelTextField(
              controller: _descriptionController,
              readOnly: true,
              label: 'Description',
              hintText: transaction.description,
            ),
            const Height(16),
            LabelTextField(
              controller: _noOfItemsController,
              readOnly: true,
              label: 'Number of item(s)',
              hintText: '2',
            ),
            const Height(16),
            LabelTextField(
              controller: _amountController,
              readOnly: true,
              label: 'Amount',
              hintText: transaction.amount.toString(),
            ),
            const Height(16),
            LabelTextField(
              controller: _deliveryTimeController,
              readOnly: true,
              label: 'Delivery timeline',
              hintText: FormatDate.ddMMYYYY(transaction.date),
            ),
            const Height(32),
            Text(
              'RECEIVER ACCOUNT INFORMATION',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 18,
                color: AppColors.g50,
              ),
            ),
            const Height(8),
            LabelTextField(
              controller: _titleController,
              readOnly: true,
              label: 'Email address',
              hintText: 'MustyFeet@gmail.com',
            ),
            const Height(184),
          ],
        ),
      ),
    );
  }
}
