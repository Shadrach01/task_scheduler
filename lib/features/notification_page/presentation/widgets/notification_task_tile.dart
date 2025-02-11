import 'package:flutter/material.dart';
import 'package:task_scheduler/core/commons/helper/get_icon_data.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class NotificationTaskTile extends StatelessWidget {
  final TaskModel task;
  const NotificationTaskTile({super.key, required this.task});
  //
  // String taskStatus = task.status == 'In Progress'
  //     ? 'In progress'
  //     : task.status == 'Completed' ?'Completed';

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      decoration: BoxDecoration(
        color: task.color.withOpacity(.3),
        borderRadius: BorderRadius.circular(appWidth * .03),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .02,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: appWidth * .03,
            children: [
              Expanded(
                child: Text(
                  "Your task: ${task.taskName} has started",
                  style: AppTextStyle.textStyle(
                    size: appWidth * .035,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: appHeight * .03,
                width: appWidth * .07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: task.color.withOpacity(.3),
                ),
                child: Icon(
                  getIconData(task.taskIcon),
                  color: task.color,
                  size: appHeight * .02,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
