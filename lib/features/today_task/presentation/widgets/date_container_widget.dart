import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/today_task/provider/today_tasks_provider.dart';

import '../../../../core/utils/app_text_style.dart';

class DateContainerWidget extends ConsumerStatefulWidget {
  final Function(DateTime) onDateSelected; // Call back to notify the parent
  const DateContainerWidget({super.key, required this.onDateSelected});

  @override
  ConsumerState<DateContainerWidget> createState() =>
      _DateContainerWidgetState();
}

class _DateContainerWidgetState extends ConsumerState<DateContainerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    final selectedDate = ref.read(todayTasksNotifierProvider).selectedDate;

    return SizedBox(
      height: appHeight * .12,
      child: ListView.builder(
        // controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _daysInMonth(
          DateTime.now().year,
          DateTime.now().month,
        ),
        itemBuilder: (context, index) {
          // Calculate the day for each iteration
          int daysToAdd = index - DateTime.now().day + 1;
          DateTime currentDate = DateTime.now().add(Duration(days: daysToAdd));

          // Format the date for display
          String formattedDate = DateFormat('d').format(currentDate);
          String formattedDay = DateFormat('EE').format(currentDate);
          String formattedMonth = DateFormat('MMM').format(currentDate);

          // Determine if this date is selected
          bool isSelectedDate = selectedDate.day == currentDate.day &&
              selectedDate.month == currentDate.month &&
              selectedDate.year == currentDate.year;

          return GestureDetector(
            onTap: widget.onDateSelected(currentDate),
            //     () {
            //   setState(() {
            //     ref
            //         .read(todayTasksNotifierProvider.notifier)
            //         .updateSelectedDate(currentDate);
            //   });
            // },
            child: Container(
              width: appWidth * .2,
              padding: EdgeInsets.symmetric(
                horizontal: appWidth * .02,
                vertical: appHeight * .01,
              ),
              margin: EdgeInsets.symmetric(horizontal: appWidth * .02),
              decoration: BoxDecoration(
                color: isSelectedDate
                    ? Colors.blue.shade900
                    : Colors.white, // Blue for selected, white otherwise
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formattedMonth,
                    style: AppTextStyle.textStyle(
                      color: isSelectedDate ? Colors.white : Colors.black,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: AppTextStyle.textStyle(
                      color: isSelectedDate ? Colors.white : Colors.black,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedDay,
                    style: AppTextStyle.textStyle(
                      color: isSelectedDate ? Colors.white : Colors.black,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
