import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/helper/navigator.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/image_res.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/home_page.dart';

class OnboardingScreenWidgets extends StatelessWidget {
  const OnboardingScreenWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      height: appHeight,
      width: appWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageRes.backgroundColor,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: appWidth * .05,
            vertical: appHeight * .03,
          ),
          child: Column(
            children: [
              Image.asset(
                ImageRes.onboardingImage,
              ),
              SizedBox(height: appHeight * .15),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appWidth * .07,
                ),
                child: Column(
                  children: [
                    Text(
                      "Task Management & To-Do List",
                      style: AppTextStyle.textStyle(
                        size: 29,
                        weight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: appHeight * .017),
                    Text(
                      "This productive tool is designed to "
                      "help you better manage your task "
                      "project-wise conveniently!",
                      style: AppTextStyle.textStyle(
                        color: Colors.grey[800]!,
                        size: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: appHeight * .05),
              button(appWidth, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(double width, BuildContext context) {
    return AppButton(
      onTap: () => AppNavigator.pushAndRemove(
        context,
        GeneralPageWithNavBar(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Start",
            style: AppTextStyle.textStyle(
              color: Colors.white,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(width: width * .2),
          Icon(
            IconlyBold.arrow_right,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
