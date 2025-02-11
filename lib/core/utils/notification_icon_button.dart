import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/helper/navigator.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/notification_page/presentation/screen/notification_screen.dart';

Widget notificationIconButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      AppNavigator.push(context, NotificationScreen());
    },
    icon: Badge(
      smallSize: context.appWidth * .03,
      child: Icon(
        IconlyBold.notification,
        size: context.appWidth * .07,
      ),
    ),
    color: Colors.black87,
  );
}
