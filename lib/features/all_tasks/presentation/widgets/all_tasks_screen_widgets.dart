import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/all_tasks/presentation/widgets/tasks_tile.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';

class AllTasksScreenWidgets extends StatelessWidget {
  const AllTasksScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight,
      width: appWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageRes.backgroundColor),
          fit: BoxFit.cover,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: appWidth * .03),
      child: Column(
        spacing: appHeight * .035,
        children: [
          _appBar(context),

          // Each task tile
          TasksTile(),
        ],
      ),
    );
  }

  // App Bar
  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "All Tasks",
        style: AppTextStyle.textStyle(
          color: Colors.black87,
          size: 20,
          weight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: IMPLEMENT THE NOTIFICATIONS ALARM ICON
          },
          icon: Icon(
            IconlyBold.notification,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
