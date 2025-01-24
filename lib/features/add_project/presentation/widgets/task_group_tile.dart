import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class TaskGroupTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String subTitle;
  const TaskGroupTile({
    super.key,
    this.leading,
    this.title = '',
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .05,
        vertical: appHeight * .018,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: appWidth * .025,
        children: [
          SizedBox(
            height: appHeight * .04,
            width: appWidth * .09,
            child: leading,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade800,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              Text(
                subTitle,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  size: 18,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              // TODO: FIX THE DROP DOWN BUTTON
            },
            icon: Icon(
              IconlyBold.arrow_down_2,
              size: appHeight * .037,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
