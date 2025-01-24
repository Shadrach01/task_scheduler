import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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
      height: appHeight * .16,
      width: appWidth,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .02,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appWidth * .05,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: appHeight * .01,
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
            child: CircleAvatar(
              radius: appHeight * .7,
            ),
          ),
          Icon(
            IconlyBold.more_square,
            size: appHeight * .038,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
