import 'package:flutter/material.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class AppSnackBar {
  static SnackBar createSnackBar(
    BuildContext context, {
    required String message,
  }) {
    return SnackBar(
      margin: EdgeInsets.only(
        right: context.appWidth * .02,
        left: context.appWidth * .02,
        bottom: context.appHeight * .1,
      ),
      content: Text(
        message,
        style: AppTextStyle.textStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade900,
      behavior: SnackBarBehavior.floating,
    );
  }

  // Function to show the snack bar
  static void show(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      createSnackBar(context, message: message),
    );
  }
}
