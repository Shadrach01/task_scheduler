import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/commons/helper/get_icon_data.dart';

class TasksDetailContainer extends StatelessWidget {
  final TaskModel task;
  final void Function() onTap;
  const TasksDetailContainer({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      width: appWidth,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .06,
        vertical: appHeight * .02,
      ),
      margin: EdgeInsets.only(bottom: appHeight * .02),
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appHeight * .005,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: appWidth * .04,
            children: [
              // Edit Task
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(appWidth * .02),
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(IconlyBold.edit),
                ),
              ),

              // Delete Task
              GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.all(appWidth * .02),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    IconlyBold.delete,
                    color: Colors.redAccent.shade400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: appHeight * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.taskGroup.toUpperCase(),
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Container(
                height: appHeight * .04,
                width: appWidth * .09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: task.color.withOpacity(.3),
                ),
                child: Icon(
                  getIconData(task.taskIcon),
                  color: task.color,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Task Name: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.taskName,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Task Desc: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.taskDescription,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  size: 18,
                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Date: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.startDay,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Start Time: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.startTime,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End Date: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.endDay,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "End Time: ",
                style: AppTextStyle.textStyle(
                  size: 15,
                  weight: FontWeight.bold,
                ),
              ),
              Text(
                task.endTime,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status:",
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  weight: FontWeight.w800,
                  size: 15,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: appWidth * .03,
                  vertical: appHeight * .008,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey.withOpacity(.3),
                ),
                child: Text(
                  task.status,
                  style: AppTextStyle.textStyle(
                    color: Colors.blueGrey,
                    size: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
