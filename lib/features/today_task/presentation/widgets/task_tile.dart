import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/helper/get_icon_data.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final void Function(BuildContext)? onPressed;
  const TaskTile({
    super.key,
    required this.task,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.35,
        motion: const BehindMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (context) {},
            backgroundColor: Colors.lightGreen,
            borderRadius: BorderRadius.circular(20),
            child: Icon(
              IconlyBold.edit,
              color: Colors.black87,
              size: appHeight * .035,
            ),
          ),
        ],
      ),
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children: [
          CustomSlidableAction(
            onPressed: onPressed,
            backgroundColor: Colors.black87,
            borderRadius: BorderRadius.circular(20),
            child: Icon(
              IconlyBold.delete,
              color: Colors.redAccent.shade700,
              size: appHeight * .03,
            ),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: appWidth * .04,
            vertical: appHeight * .02,
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: appHeight * .01,
                children: [
                  Text(
                    task.taskGroup,
                    style: AppTextStyle.textStyle(
                      color: Colors.grey.shade700,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    task.taskName,
                    style: AppTextStyle.textStyle(
                      color: Colors.black87,
                      size: 18,
                      weight: FontWeight.w800,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: appWidth * .01,
                    children: [
                      Icon(
                        IconlyBold.time_circle,
                        color: Colors.blueGrey.withOpacity(.5),
                        size: appHeight * .02,
                      ),
                      Text(
                        task.startTime,
                        style: AppTextStyle.textStyle(
                          color: Colors.blueGrey.withOpacity(.5),
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                  SizedBox(height: appHeight * .03),
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
        ),
      ),
    );
  }
}
