import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/themes/app_colors.dart';

class CalendarDialog extends StatefulWidget {
  final Function(DateTime? start, DateTime? end)? onDateRangeSelected;
  final Function(DateTime? date) onDateSelected;
  const CalendarDialog({
    super.key,
    this.onDateRangeSelected,
    required this.onDateSelected,
  });

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  final DateTime _focusedDay = DateTime.now();
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
            lastDay: DateTime(DateTime.now().year + 1),
            rangeSelectionMode: RangeSelectionMode.disabled,
            onDaySelected: (selectedDay, focusedDay) {
              focusedDay = selectedDay;
              widget.onDateSelected(selectedDay);

              Navigator.of(context).pop();
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
