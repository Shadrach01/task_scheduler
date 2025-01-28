import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class TaskGroupTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String subTitle;
  final double subTitleSize;
  final VoidCallback? onArrowPressed;
  const TaskGroupTile({
    super.key,
    this.leading,
    this.title = '',
    this.subTitle = '',
    this.subTitleSize = 18,
    this.onArrowPressed,
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
        mainAxisAlignment: leading == null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: appWidth * .025,
        children: [
          if (leading != null) leading!,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade800,
                  size: 15,
                  weight: FontWeight.w400,
                ),
              ),
              Text(
                subTitle,
                style: AppTextStyle.textStyle(
                  color: Colors.black87,
                  size: subTitleSize,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (leading != null) Spacer(),
          if (leading != null)
            IconButton(
              onPressed: onArrowPressed,
              icon: Icon(
                IconlyBold.arrow_down_2,
                size: appHeight * .03,
                color: Colors.black87,
              ),
            )
          else
            Expanded(
              child: IconButton(
                onPressed: onArrowPressed,
                icon: Icon(
                  IconlyBold.arrow_down_2,
                  size: appHeight * .03,
                  color: Colors.black87,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
