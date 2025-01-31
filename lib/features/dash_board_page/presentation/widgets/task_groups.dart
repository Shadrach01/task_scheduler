import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_scheduler/core/commons/helper/get_icon_data.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../today_task/provider/today_tasks_provider.dart';

class TaskGroups extends ConsumerWidget {
  final ScrollController _controller = ScrollController();

  TaskGroups({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = context.appHeight;
    final width = context.appWidth;

    final taskState = ref.watch(todayTasksNotifierProvider);
    final taskList = taskState.tasks;
    log("Task List DashBoard: $taskList");

    final Map<String, Map<String, dynamic>> groupedTasks = {};
    log('Grouped tasks dashboard: $groupedTasks');

    log("Number of task groups: ${groupedTasks.keys.length}");

    for (var task in taskList) {
      if (!groupedTasks.containsKey(task.taskGroup)) {
        groupedTasks[task.taskGroup] = {
          'count': 0,
          'color': task.color,
          'icon': task.taskIcon,
        };
      }

      groupedTasks[task.taskGroup]!['count'] += 1;
    }

    return Column(
      // spacing: height * .002,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: width * .01,
          children: [
            Text(
              "Task Groups",
              style: AppTextStyle.textStyle(
                color: Colors.black87,
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            Container(
              height: height * .05,
              width: width * .05,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  groupedTasks.keys.length.toString(),
                  style: AppTextStyle.textStyle(
                    color: Colors.blueGrey,
                    size: 14,
                  ),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: groupedTasks.keys.isEmpty
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * .06,
                    horizontal: width * .2,
                  ),
                  child: Text(
                    'No set tasks yet',
                    style:
                        AppTextStyle.textStyle(color: Colors.black87, size: 24),
                  ),
                )
              : ListView.builder(
                  controller: _controller,
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  itemCount: groupedTasks.keys.length,
                  itemBuilder: (context, index) {
                    final taskGroupTitle = groupedTasks.keys.elementAt(index);
                    final groupInfo = groupedTasks[taskGroupTitle]!;
                    final availableTasks = groupInfo['count'].toString();
                    final groupColor = groupInfo['color'];
                    final groupIcon = groupInfo['icon'] as String;

                    // Project tile
                    return projectTile(
                      height,
                      width,
                      taskGroupTitle,
                      availableTasks.toString(),
                      groupColor,
                      groupIcon,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget projectTile(
    double height,
    double width,
    String taskGroup,
    String availableTasks,
    Color groupColor,
    String groupIcon,
  ) {
    return Container(
      height: height * .09,
      margin: EdgeInsets.symmetric(
        vertical: height * .01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.3),
            offset: Offset(.4, .5),
            spreadRadius: .06,
            blurRadius: .02,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: width * .035,
        children: [
          Container(
            height: height * .05,
            width: width * .11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: groupColor.withOpacity(.3),
            ),
            child: Icon(
              getIconData(groupIcon),
              color: groupColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                taskGroup,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  size: 18,
                  weight: FontWeight.w600,
                ),
              ),
              Text(
                "$availableTasks tasks",
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 18,
                  weight: FontWeight.w600,
                ),
              )
            ],
          ),
          Spacer(),
          CircularPercentIndicator(
            backgroundColor: groupColor.withOpacity(.3),
            animation: true,
            percent: .7,
            progressColor: groupColor,
            radius: width * .05,
          ),
        ],
      ),
    );
  }
}
