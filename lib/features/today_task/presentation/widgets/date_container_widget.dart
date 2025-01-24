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
  // List of colors for the TodoTiles
  final List<Color> todoTileColors = [
    Colors.red,
    Colors.white,
  ];

  PageController? _pageController;

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _calculateInitialPageIndex(),
      viewportFraction: 0.2,
    );

    // Set the initially selected date to the current date
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return SizedBox(
      height: appHeight * .12,
      width: appWidth * 15,
      child: PageView.builder(
        padEnds: false,
        pageSnapping: false,
        controller: _pageController,
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
            child: Center(
              child: Container(
                width: appWidth * .4,
                padding: EdgeInsets.symmetric(
                  horizontal: appWidth * .01,
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
            ),
          );
        },
      ),
    );
  }

  int _calculateInitialPageIndex() {
    DateTime currentDate = DateTime.now();

    // Calculate the index corresponding to the current date
    int currentIndex = currentDate.day - 1;

    return currentIndex;
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
