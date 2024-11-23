import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../config/themes/app_colors.dart';

class CalendarDialog extends StatefulWidget {
  final Function(DateTime? start, DateTime? end) onDateRangeSelected;
  const CalendarDialog({super.key, required this.onDateRangeSelected});

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
              if (start != null && end != null) {
                // Pass the selected range to the callback
                widget.onDateRangeSelected(start, end);

                // Close the dialog
                Navigator.of(context).pop();
              }
            },
            // onDaySelected: (selectedDay, focusedDay) {
            //   setState(() {
            //     _focusedDay = focusedDay;
            //     _rangeStart = selectedDay;
            //     _rangeEnd = null;
            //   });
            // },
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
