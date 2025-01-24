import 'package:flutter/material.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight * .09,
      margin: EdgeInsets.symmetric(
        vertical: appHeight * .01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .01,
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
        spacing: appWidth * .035,
        children: [
          Container(
            height: appHeight * .05,
            width: appWidth * .11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrangeAccent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Office Project",
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  size: 20,
                  weight: FontWeight.w600,
                ),
              ),
              Text(
                "23, tasks",
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 18,
                  weight: FontWeight.w600,
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            height: appHeight * .12,
            width: appWidth * .12,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
