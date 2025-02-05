import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/today_task/provider/today_tasks_provider.dart';

class BannerContainer extends ConsumerWidget {
  const BannerContainer({super.key});

  double calculateTodayTaskProgress(List<TaskModel> tasks) {
    // Get today's date formatted the same way as task dates
    final today = DateFormat('dd MMM yyyy').format(DateTime.now());

    // Filter tasks for today
    final todayTasks = tasks.where((task) => task.startDay == today).toList();

    if (todayTasks.isEmpty) return 0.00;

    // Count completed tasks
    final completedTasks =
        todayTasks.where((task) => task.status == 'Completed').length;

    // Calculate percentage
    return completedTasks / todayTasks.length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    // Get all tasks from the provider
    final tasks = ref.watch(todayTasksNotifierProvider).tasks;

    // Calculate progress percentage
    final progress = calculateTodayTaskProgress(tasks);
    final progressPercentage = (progress * 100).toInt();

    //Determine message based on progress
    String message = "No tasks scheduled for today";

    if (tasks.isNotEmpty) {
      if (progress == 1.0) {
        message = "All today's tasks are completed!";
      } else if (progress > 0.5) {
        message = "Your today's tasks are almost done!";
      } else {
        message = "Keep going with today's tasks!";
      }
    }
    return Container(
      height: appHeight * .2,
      width: appWidth,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .075,
        vertical: appHeight * .025,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: appWidth * .08,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  message,
                  style: AppTextStyle.textStyle(
                    color: Colors.white,
                    weight: FontWeight.w400,
                    size: 18,
                  ),
                ),
                SizedBox(
                  height: appHeight * .05,
                  width: appWidth * .35,
                  child: AppButton(
                    color: Colors.white,
                    child: Text(
                      "View Task",
                      style: AppTextStyle.textStyle(
                        color: Colors.blue.shade900,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // TODO: IMPLEMENT NAV TO VIEW TASK
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CircularPercentIndicator(
              radius: appWidth * .135,
              animation: true,
              lineWidth: appWidth * .03,
              percent: progress,
              progressColor: Colors.white,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                "$progressPercentage%",
                style: AppTextStyle.textStyle(
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
