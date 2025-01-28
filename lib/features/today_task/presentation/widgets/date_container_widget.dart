import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/utils/app_text_style.dart';

class DateContainerWidget extends StatefulWidget {
  const DateContainerWidget({super.key});

  @override
  State<DateContainerWidget> createState() => _DateContainerWidgetState();
}

class _DateContainerWidgetState extends State<DateContainerWidget> {
  late ScrollController _scrollController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Set the initially selected date to the current date
    _selectedDate = DateTime.now();

    // Initialize ScrollController
    _scrollController = ScrollController();

    // Scroll to the current date after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentDate();
    });
  }

  void _scrollToCurrentDate() {
    // Calculate the scroll offset for the current date
    double offset = (_selectedDate!.day - 1) *
        context.appWidth *
        0.24; // Adjust multiplier for item width + margin
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    return SizedBox(
      height: appHeight * .12,
      child: ListView.builder(
        controller: _scrollController,
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
          bool isSelectedDate = _selectedDate?.day == currentDate.day &&
              _selectedDate?.month == currentDate.month &&
              _selectedDate?.year == currentDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = currentDate;
              });
            },
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
