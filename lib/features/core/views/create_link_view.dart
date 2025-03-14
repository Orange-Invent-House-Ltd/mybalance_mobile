import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/validators.dart';
import '../../../core/shared/widgets/custom_app_bar.dart';
import '../../../core/shared/widgets/label_text_field.dart';
import '../../../core/shared/widgets/sizedbox.dart';
import './widgets/calendar_dialog.dart';

class CreateLinkView extends StatefulWidget {
  const CreateLinkView({super.key});

  @override
  State<CreateLinkView> createState() => _CreateLinkViewState();
}

class _CreateLinkViewState extends State<CreateLinkView> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _titleController,
      _descriptionController,
      _noItemController,
      _amountController,
      _timelineController,
      _emailController;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _noItemController = TextEditingController();
    _amountController = TextEditingController();
    _timelineController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _noItemController.dispose();
    _amountController.dispose();
    _timelineController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        theme: theme,
        text: 'Create MyBalance Link',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create your MyBalance escrow information and share with everyone. During payment, our charges will be included.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.g500,
                ),
              ),
              const Height(24),
              Text(
                'ITEM(S) INFORMATION',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
              LabelTextField(
                controller: _titleController,
                validator: Validator.notEmptyValidator,
                label: 'Title',
                hintText: 'Purchase of sneakers',
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _descriptionController,
                label: 'Description',
                hintText: 'Gucci sneakers',
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _noItemController,
                validator: Validator.notEmptyValidator,
                label: 'Number of item(s)',
                hintText: '1',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _amountController,
                validator: Validator.notEmptyValidator,
                label: 'Amount',
                hintText: '20,000',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _timelineController,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CalendarDialog(
                      onDateSelected: (date) {
                        if (date != null) {
                          _timelineController.text = FormatDate.ddMMYYYY(date);
                        }
                      },
                      // onDateRangeSelected: (DateTime? start, DateTime? end) {
                      //   if (start != null && end != null) {
                      //     _timelineController.text =
                      //         '${FormatDate.ddMMYYYY(start)} - ${FormatDate.ddMMYYYY(end)}';
                      //     log('Selected range: $start - $end');
                      //   } else if (start != null) {
                      //     _timelineController.text = FormatDate.ddMMYYYY(start);
                      //     log('Selected date: $start');
                      //   }
                      // },
                    ),
                  );
                },
                label: 'Delivery timeline',
                hintText: '__/__/____',
                readOnly: true,
              ),
              const Height(24),
              Text(
                'VENDOR ACCOUNT INFORMATION',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
              LabelTextField(
                controller: _emailController,
                validator: Validator.emailValidator,
                label: 'Email address',
                hintText: 'Mustyfeet@gmail.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const Height(32),
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                    listenable: Listenable.merge([
                      _titleController,
                      _descriptionController,
                      _noItemController,
                      _amountController,
                      _timelineController,
                      _emailController,
                    ]),
                    builder: (context, child) {
                      return ElevatedButton(
                        onPressed: _titleController.text.isEmpty ||
                                _descriptionController.text.isEmpty ||
                                _noItemController.text.isEmpty ||
                                _amountController.text.isEmpty ||
                                _timelineController.text.isEmpty ||
                                _emailController.text.isEmpty
                            ? null
                            : () {},
                        child: const Text('Pay now'),
                      );
                    }),
              ),
              const Height(184),
            ],
          ),
        ),
      ),
    );
  }
}
