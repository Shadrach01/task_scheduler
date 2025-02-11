import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/commons/widgets/app_button.dart';
import 'package:task_scheduler/core/utils/notification_icon_button.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/user_profile_screen/presentation/widgets/user_name_text_field.dart';

import '../../../../core/commons/helper/navigator.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';
import '../../controller/input_user_details_controller.dart';
import '../../provider/notifier_provider.dart';

class UserProfileWidgets extends ConsumerStatefulWidget {
  const UserProfileWidgets({super.key});

  @override
  ConsumerState<UserProfileWidgets> createState() => _UserScreenWidgetsState();
}

class _UserScreenWidgetsState extends ConsumerState<UserProfileWidgets> {
  late InputUserDetailsController _controller;

  @override
  void initState() {
    _controller = InputUserDetailsController();

    // Load user data from Hive when the widget is first created
    _controller.loadUserDetailsFromHive(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;
    final userState = ref.watch(inputUserDetailsNotifierProvider);
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
          spacing: appHeight * .08,
          children: [
            // App Bar
            _appBar(context),

            // Profile Picture
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: userState.profilePicture.isNotEmpty
                      ? FileImage(File(userState.profilePicture))
                          as ImageProvider
                      : null,
                  radius: appWidth * .2,
                  child: userState.profilePicture.isEmpty
                      ? Icon(
                          IconlyBold.user_2,
                          color: Colors.grey.shade700,
                          size: appWidth * .3,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.shade200,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: IconButton(
                      onPressed: () => _controller.pickImage(ref),
                      icon: Icon(
                        IconlyBold.camera,
                        size: appHeight * .04,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
              ],
            ),

            // User name
            UserNameTextField(
              controller: _controller.userNameController,
              onChanged: (value) => ref
                  .read(inputUserDetailsNotifierProvider.notifier)
                  .onUserNameChanged(value),
              initialUsername: userState.userName,
            ),

            // Save Button
            AppButton(
                child: Text(
                  'Save Details',
                  style: AppTextStyle.textStyle(color: Colors.white),
                ),
                onTap: () => _controller.saveUserDetailsToHive(ref))
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
        "Profile",
        style: AppTextStyle.textStyle(
          color: Colors.black87,
          size: 20,
          weight: FontWeight.w700,
        ),
      ),
      actions: [
        notificationIconButton(context),
      ],
    );
  }
}
