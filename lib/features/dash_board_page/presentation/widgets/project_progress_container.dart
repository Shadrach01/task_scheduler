import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/commons/helper/get_icon_data.dart';

class ProjectProgressContainer extends StatelessWidget {
  final TaskModel task;
  const ProjectProgressContainer({super.key, required this.task});

  double _calculateTaskProgress() {
    final now = DateTime.now();

    // Parse the start date and time
    final startDate = DateFormat('dd MMM yyyy').parse(task.startDay);
    final startTime = DateFormat('hh:mm a').parse(task.startTime);
    final startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    // parse the end date and time
    final endDate = DateFormat('dd MMM yyyy').parse(task.endDay);
    final endTime = DateFormat('hh:mmm a').parse(task.endTime);

    final endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );

    // if task hasn't started yet
    if (now.isBefore(startDateTime)) {
      return 0.0;
    }

    // If task is completed or past end time
    if (now.isAfter(endDateTime)) {
      return 1.0;
    }

    final totalDuration = endDateTime.difference(startDateTime).inMinutes;
    final elapsedDuration = now.difference(startDateTime).inMinutes;

    return elapsedDuration / totalDuration;
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) {
      return Colors.green;
    } else if (progress > 0.7) {
      return Colors.orange;
    } else {
      return task.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    final progress = _calculateTaskProgress();

    return Container(
      width: appWidth * .6,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .01,
      ),
      margin: EdgeInsets.only(right: appWidth * .05),
      decoration: BoxDecoration(
        color: task.color.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appHeight * .001,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.taskGroup,
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 15,
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
          Text(
            task.taskName,
            style: AppTextStyle.textStyle(
              size: 20,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(height: appHeight * .02),
          LinearPercentIndicator(
            backgroundColor: Colors.white,
            animation: true,
            lineHeight: appHeight * .015,
            percent: progress.clamp(0.0, 1.0),
            progressColor: _getProgressColor(progress),
            barRadius: Radius.circular(10),
          ),
        ],
      ),
    );
  }
}
