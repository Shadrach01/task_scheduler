import 'package:flutter/material.dart';
import 'package:task_scheduler/core/commons/widgets/app_text_field.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/utils/app_text_style.dart';

class ProjectDetailsTile extends StatelessWidget {
  final String containerTitle;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const ProjectDetailsTile({
    super.key,
    this.containerTitle = '',
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .05,
        vertical: appHeight * .01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appWidth * .025,
        children: [
          Text(
            containerTitle,
            style: AppTextStyle.textStyle(
              color: Colors.grey.shade700,
              size: 14,
              weight: FontWeight.w500,
            ),
          ),

          // TextField
          AppTextField(
            controller: controller,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
