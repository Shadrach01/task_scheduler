import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/task_model/task_model.dart';
import '../provider/today_tasks_provider.dart';

class TodayTaskController {
  TodayTaskController();

  // Get all tasks
  Future<List<TaskModel>?> getAllTasks(WidgetRef ref) async {
    final allTasks =
        await ref.read(todayTasksNotifierProvider.notifier).loadAllTasks();
    log("All tasks from controller: $allTasks");
    return allTasks;
  }
}
