import 'package:flutter/material.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class ProjectProgressContainer extends StatelessWidget {
  const ProjectProgressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight * .11,
      width: appWidth * .6,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .01,
      ),
      margin: EdgeInsets.only(right: appWidth * .05),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
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
                "Office Project",
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 15,
                ),
              ),
              Container(
                height: appHeight * .03,
                width: appWidth * .07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ],
          ),
          Text(
            "Grocery shopping app design",
            style: AppTextStyle.textStyle(
              size: 20,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(height: appHeight * .02),
          LinearProgressIndicator(
            backgroundColor: Colors.blue,
            minHeight: appHeight * .015,
            borderRadius: BorderRadius.circular(20),
          )
        ],
      ),
    );
  }
}
