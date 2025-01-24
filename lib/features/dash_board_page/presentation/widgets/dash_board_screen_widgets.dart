import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/dash_board_page/presentation/widgets/project_progress_container.dart';
import 'package:task_scheduler/features/dash_board_page/presentation/widgets/project_tile.dart';

import '../../../../core/utils/image_res.dart';
import 'banner_container.dart';

class DashBoardScreenWidgets extends StatelessWidget {
  const DashBoardScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight,
      width: appWidth,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .05,
        vertical: appHeight * .01,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageRes.backgroundColor,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: appHeight * .015,
            children: [
              homePageAppBar(appWidth),

              // Task almost done container
              BannerContainer(),

              // Project tasks that are in progress
              progressContainer(appWidth, appHeight),

              // Task Groups
              taskGroups(appWidth, appHeight),
            ],
          ),
        ),
      ),
    );
  }

  // App bar
  AppBar homePageAppBar(double width) {
    return AppBar(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: width * .055,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello!",
            style: AppTextStyle.textStyle(
              size: 19,
            ),
          ),
          Text(
            "Livia Vaccaro",
            style: AppTextStyle.textStyle(
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        Icon(
          IconlyBold.notification,
          color: Colors.black87,
        ),
      ],
    );
  }

  // In Progress text and containers
  Widget progressContainer(double width, double height) {
    return Column(
      spacing: height * .002,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: width * .01,
          children: [
            Text(
              "In progress",
              style: AppTextStyle.textStyle(
                color: Colors.black87,
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            Container(
              height: height * .05,
              width: width * .05,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "6",
                  style: AppTextStyle.textStyle(
                    color: Colors.blueGrey,
                    size: 14,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: height * .16,
          width: width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return ProjectProgressContainer();
            },
          ),
        ),
      ],
    );
  }

  // Task Groups
  Widget taskGroups(double width, double height) {
    return Column(
      // spacing: height * .002,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: width * .01,
          children: [
            Text(
              "Task Groups",
              style: AppTextStyle.textStyle(
                color: Colors.black87,
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            Container(
              height: height * .05,
              width: width * .05,
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "4",
                  style: AppTextStyle.textStyle(
                    color: Colors.blueGrey,
                    size: 14,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: height * .5,
          width: width,
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              // Project tile
              return ProjectTile();
            },
          ),
        ),
      ],
    );
  }
}
