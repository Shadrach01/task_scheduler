import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/helper/navigator.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/image_res.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/add_project/presentation/widgets/project_details_tile.dart';
import 'package:task_scheduler/features/add_project/presentation/widgets/task_group_tile.dart';

class AddProjectWidgets extends StatelessWidget {
  const AddProjectWidgets({super.key});

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
      child: SingleChildScrollView(
        child: Column(
          spacing: appHeight * .03,
          children: [
            // App Bar
            _appBar(context),

            // Add task tile
            TaskGroupTile(
              leading: Container(
                height: appHeight * .04,
                width: appWidth * .09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepOrangeAccent,
                ),
              ),
              title: "Task Group",
              subTitle: "Work",
            ),

            // Project Name
            ProjectDetailsTile(
              containerTitle: 'Project Name',
            ),

            // Project details
            ProjectDetailsTile(
              containerTitle: 'Description',
            ),

            //Start Date
            TaskGroupTile(
              leading: Icon(
                IconlyBold.calendar,
                color: Colors.blue,
                size: appHeight * .04,
              ),
              title: "Start Date",
              subTitle: "01 May, 2022",
            ),

            //End Date
            TaskGroupTile(
              leading: Icon(
                IconlyBold.calendar,
                color: Colors.blue,
                size: appHeight * .04,
              ),
              title: "End Date",
              subTitle: "30 June, 2022",
            ),
            SizedBox(height: appHeight * .01),
            AppButton(
              child: Text(
                "Save Task",
                style: AppTextStyle.textStyle(color: Colors.white, size: 20),
              ),
              onTap: () => AppNavigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  // App Bar
  Widget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => AppNavigator.pop(context),
        icon: Icon(IconlyBold.arrow_left),
      ),
      centerTitle: true,
      title: Text(
        "Add Task",
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
