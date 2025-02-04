import 'package:flutter/material.dart';
import 'package:mybalanceapp/core/widgets/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/themes/app_colors.dart';
import '../../../core/widgets/label_text_field.dart';
import '../../../core/widgets/sizedbox.dart';

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
      // appBar: AppBar(
      //   backgroundColor: theme.scaffoldBackgroundColor,
      //   scrolledUnderElevation: 0,
      //   leading: const Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Width(25),
      //       AppBackButton(),
      //     ],
      //   ),
      //   title: Text(
      //     'Create MyBalance Link',
      //     style: theme.textTheme.titleLarge?.copyWith(
      //       fontSize: 23,
      //       color: AppColors.b300,
      //     ),
      //   ),
      // ),
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
                  fontSize: 18,
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
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
                hintText: 'Gucci sneakers',
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _noItemController,
                label: 'Number of item(s)',
                hintText: '1',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const Height(16),
              LabelTextField(
                controller: _amountController,
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
                    builder: (context) => const CalendarDialog(),
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
                  fontSize: 18,
                  color: AppColors.g50,
                ),
              ),
              const Height(16),
              LabelTextField(
                controller: _emailController,
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

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({super.key});

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            focusedDay: _focusedDay,
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            lastDay: DateTime(DateTime.now().year + 1),
            rangeSelectionMode: RangeSelectionMode.toggledOn,
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _rangeStart = start;
                _rangeEnd = end;
                _focusedDay = focusedDay;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                _rangeStart = selectedDay;
                _rangeEnd = null;
              });
            },
            pageJumpingEnabled: false,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              disabledTextStyle: textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                color: AppColors.g75,
              ),
              defaultTextStyle: textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                color: AppColors.p300,
              ),
              weekendTextStyle: textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                color: AppColors.p300,
              ),
              todayTextStyle: textTheme.bodyMedium!.copyWith(fontSize: 13),
              todayDecoration: const BoxDecoration(
                color: AppColors.p300,
                shape: BoxShape.circle,
              ),
              rangeStartDecoration: const BoxDecoration(
                color: AppColors.p100,
                shape: BoxShape.circle,
              ),
              rangeEndDecoration: const BoxDecoration(
                color: AppColors.p100,
                shape: BoxShape.circle,
              ),
              rangeHighlightColor: AppColors.p50,
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.b300,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: textTheme.labelSmall!
                  .copyWith(fontSize: 10, color: AppColors.g300),
              weekendStyle: textTheme.labelSmall!
                  .copyWith(fontSize: 10, color: AppColors.g300),
            ),
          ),
        ],
      ),
    );
  }
}
