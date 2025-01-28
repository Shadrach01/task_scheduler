import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class TaskTile extends StatelessWidget {
  final String taskGroup;
  // final IconData taskIcon;
  final String taskName;
  final String taskDescription;
  final String taskStartTime;
  const TaskTile({
    super.key,
    required this.taskGroup,
    // required this.taskIcon,
    required this.taskName,
    required this.taskDescription,
    required this.taskStartTime,
  });

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Card(
      color: Colors.white,
      elevation: .6,
      borderOnForeground: false,
      margin: EdgeInsets.only(bottom: appHeight * .02),
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
                  taskGroup,
                  style: AppTextStyle.textStyle(
                    color: Colors.grey.shade700,
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                ),
                Text(
                  taskName,
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
                      taskStartTime,
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
                  height: appHeight * .03,
                  width: appWidth * .07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrangeAccent,
                  ),
                  // child: Icon(
                  //   taskIcon,
                  // ),
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
                    "Done",
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
    );
  }
}
