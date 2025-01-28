import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/constants.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/add_project/controller/task_input_controller.dart';
import 'package:task_scheduler/features/add_project/provider/task_notifier_provider.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/date_container_widget.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/task_tile.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';

class TodayTaskWidgets extends ConsumerStatefulWidget {
  const TodayTaskWidgets({super.key});

  @override
  ConsumerState<TodayTaskWidgets> createState() => _TodayTaskWidgetsState();
}

class _TodayTaskWidgetsState extends ConsumerState<TodayTaskWidgets> {
  final TaskController _controller = TaskController();

  // Track the currently selected button
  int _selectedButton = 0;

  @override
  void initState() {
    super.initState();
    _controller.getAllTasks(ref);
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    // Listen to the tasks state from riverpod
    final tasks = ref.watch(inputTaskDetailsNotifierProvider).tasks;
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

          // Date Container
          DateContainerWidget(),

          // All To-do buttons
          _buttonsRow(appHeight, appWidth),

          // Tasks tile
          Expanded(child: _taskTile(appHeight, tasks)),
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
    final buttonsTexts = Constants.buttonsRowTexts;
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
  Widget _taskTile(double height, List<TaskModel> tasks) {
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
                return TaskTile(
                  taskGroup: task.taskGroup,
                  // taskIcon: null,
                  taskName: task.taskName,
                  taskDescription: task.taskDescription,
                  taskStartTime: task.startTime,
                );
              },
            ),
    );
  }
}
