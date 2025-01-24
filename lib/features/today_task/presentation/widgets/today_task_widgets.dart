import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/date_container_widget.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/task_tile.dart';

import '../../../../core/commons/helper/navigator.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';

class TodayTaskWidgets extends StatefulWidget {
  const TodayTaskWidgets({super.key});

  @override
  State<TodayTaskWidgets> createState() => _TodayTaskWidgetsState();
}

class _TodayTaskWidgetsState extends State<TodayTaskWidgets> {
  // Track the currently selected button
  int _selectedButton = 0;
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

            // Date Container
            DateContainerWidget(),

            // All To-do buttons
            _buttonsRow(appHeight, appWidth),

            // Tasks tile
            _taskTile(appHeight),
          ],
        ),
      ),
    );
  }

  // App Bar
  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => AppNavigator.pop(context),
        icon: Icon(IconlyBold.arrow_left),
      ),
      centerTitle: true,
      title: Text(
        "Today Task",
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

  // Button Rows
  Widget _buttonsRow(double height, double width) {
    final buttonsTexts = ["All", "To Do", "In Progress", "Completed"];
    return SizedBox(
      height: height * .07,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: width * .03),
        itemCount: buttonsTexts.length,
        itemBuilder: (context, index) {
          bool isSelected = _selectedButton == index;
          return SizedBox(
            width: width * 0.4,
            child: AppButton(
              color: isSelected ? Colors.blue.shade900 : Colors.grey[300],
              child: Text(
                buttonsTexts[index],
                style: AppTextStyle.textStyle(
                  color: isSelected ? Colors.white : Colors.blue.shade900,
                  size: 18,
                  weight: FontWeight.bold,
                ),
              ),
              onTap: () {
                setState(() {
                  // update selected button index
                  _selectedButton = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  // Tasks tile
  Widget _taskTile(double height) {
    return SizedBox(
      height: height * .8,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0),
        itemCount: 6,
        itemBuilder: (context, index) {
          return TaskTile();
        },
      ),
    );
  }
}
