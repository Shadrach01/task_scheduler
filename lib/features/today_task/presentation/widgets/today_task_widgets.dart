import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart' as intl;
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/constants.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/today_task/controller/today_task_controller.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/task_tile.dart';
import 'package:task_scheduler/features/today_task/provider/today_tasks_provider.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';

class TodayTaskWidgets extends ConsumerStatefulWidget {
  const TodayTaskWidgets({super.key});

  @override
  ConsumerState<TodayTaskWidgets> createState() => _TodayTaskWidgetsState();
}

class _TodayTaskWidgetsState extends ConsumerState<TodayTaskWidgets> {
  final TodayTaskController _controller = TodayTaskController();
  late ScrollController _scrollController;

  // Track the currently selected button
  int _selectedButton = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Defer the task loading to after the widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAllTasks(ref);
      _scrollToCurrentDate();
    });
  }

  void _scrollToCurrentDate() {
    final currentDay = DateTime.now().day;
    // Calculate position based on container width and current day
    // Container width = container width + horizontal margin
    final containerWidth = MediaQuery.of(context).size.width * 0.2 +
        MediaQuery.of(context).size.width * 0.04;
    final position = (currentDay - 1) * containerWidth;

    // Scroll to the position
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    final tasks = ref
        .read(todayTasksNotifierProvider.notifier)
        .filterTasksByDateAndStatus();

    return Container(
      height: appHeight,
      width: appWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageRes.backgroundColor),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: appWidth * .03),
      child: Column(
        spacing: appHeight * .03,
        children: [
          // App Bar
          _appBar(context),

          _dateContainer(appHeight, appWidth),

          // All To-do buttons
          _buttonsRow(appHeight, appWidth),

          // Tasks tile
          Expanded(child: _taskTile(appHeight, appWidth, tasks)),
        ],
      ),
    );
  }

  // App Bar
  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Today Task",
        style: AppTextStyle.textStyle(
          color: Colors.black87,
          size: 20,
          weight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: IMPLEMENT THE NOTIFICATIONS ALARM ICON
          },
          icon: Icon(
            IconlyBold.notification,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

// Button Rows
  Widget _buttonsRow(double height, double width) {
    final buttonsTexts = Constants.tasksStatus;
    return SizedBox(
      height: height * .07,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: width * .03),
        itemCount: buttonsTexts.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedButton == index;

          // Dynamically calculate width based on text size
          double buttonWidth = _calculateButtonWidth(buttonsTexts[index]);

          return SizedBox(
            width: buttonWidth,
            child: AppButton(
              color: isSelected ? Colors.blue.shade900 : Colors.grey[300],
              child: Text(
                buttonsTexts[index],
                style: AppTextStyle.textStyle(
                  color: isSelected ? Colors.white : Colors.blue.shade900,
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedButton = index;
                  ref
                      .read(todayTasksNotifierProvider.notifier)
                      .updateSelectedButtonStatus(buttonsTexts[index]);
                });
              },
            ),
          );
        },
      ),
    );
  }

// Helper method to calculate button width dynamically
  double _calculateButtonWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTextStyle.textStyle(size: 18, weight: FontWeight.bold),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width + 70; // Add padding for spacing
  }

  // Tasks tile
  Widget _taskTile(double height, double width, List<TaskModel> tasks) {
    return SizedBox(
      height: height * .8,
      child: tasks.isEmpty
          ? Text(
              "No set task yet!",
              style: AppTextStyle.textStyle(
                color: Colors.black87,
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 0),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: height * .009),
                  child: TaskTile(
                    task: task,
                  ),
                );
              },
            ),
    );
  }

  Widget _dateContainer(double appHeight, double appWidth) {
    final selectedDate = ref.read(todayTasksNotifierProvider).selectedDate;
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
          String formattedDate = intl.DateFormat('d').format(currentDate);
          String formattedDay = intl.DateFormat('EE').format(currentDate);
          String formattedMonth = intl.DateFormat('MMM').format(currentDate);

          // Determine if this date is selected
          bool isSelectedDate = selectedDate.day == currentDate.day &&
              selectedDate.month == currentDate.month &&
              selectedDate.year == currentDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                ref
                    .read(todayTasksNotifierProvider.notifier)
                    .updateSelectedDate(currentDate);
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
