import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';
import 'package:task_scheduler/features/all_tasks/presentation/widgets/tasks_details_container.dart';
import 'package:task_scheduler/features/today_task/provider/today_tasks_provider.dart';

import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/image_res.dart';

class AllTasksScreenWidgets extends ConsumerWidget {
  const AllTasksScreenWidgets({super.key});

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
      padding: EdgeInsets.symmetric(horizontal: appWidth * .05),
      child: Column(
        // spacing: appHeight * .035,
        children: [
          _appBar(context),

          // Each task tile
          Column(
            children: [
              taskTileListView(appHeight, ref),
            ],
          ),
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

  // Tasks tile list view
  Widget taskTileListView(double height, WidgetRef ref) {
    final tasks = ref.watch(todayTasksNotifierProvider).tasks;
    return SizedBox(
      height: height * .8,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: TasksDetailContainer(
              task: task,
            ),
          );
        },
      ),
    );
  }
}
