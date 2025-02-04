import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/today_tasks_provider.dart';

class TodayTaskController {
  TodayTaskController();

  // Get all tasks
  Future getAllTasks(WidgetRef ref) async {
    final allTasks =
        await ref.read(todayTasksNotifierProvider.notifier).loadTasks();
    return allTasks;
  }
}
