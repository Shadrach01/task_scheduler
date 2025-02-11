import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/notification_page/presentation/widgets/notification_task_tile.dart';
import 'package:task_scheduler/features/notification_page/provider/notified_tasks_notifier.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';
import '../../../today_task/provider/today_tasks_provider.dart';

class NotificationScreenWidgets extends ConsumerWidget {
  const NotificationScreenWidgets({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        spacing: appHeight * .03,
        children: [
          // App Bar
          _appBar(context),

          notificationTaskTileList(appHeight, ref),
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
        "Notifications",
        style: AppTextStyle.textStyle(
          color: Colors.black87,
          size: 20,
          weight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget notificationTaskTileList(double height, WidgetRef ref) {
    final startedTasks = ref.watch(notifiedTasksProvider).startedTasks;
    final endedTasks = ref.watch(notifiedTasksProvider).endedTasks;

    // Merge both lists
    final allTasks = [...startedTasks, ...endedTasks];
    return SizedBox(
      height: height * .8,
      child: allTasks.isEmpty
          ? Center(
              child: Text(
                "No Notification for you",
                style: AppTextStyle.textStyle(
                  size: 24,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: allTasks.length,
              itemBuilder: (context, index) {
                final task = allTasks[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: NotificationTaskTile(task: task),
                );
              },
            ),
    );
  }
}
