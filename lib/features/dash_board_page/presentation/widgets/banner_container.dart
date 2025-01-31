import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
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
                  "Your today's task is almost done!",
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
              percent: 0.85,
              progressColor: Colors.white,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                "85%",
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
