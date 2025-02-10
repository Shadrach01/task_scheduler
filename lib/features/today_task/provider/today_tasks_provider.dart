import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/features/today_task/provider/today_task_state.dart';
import 'package:task_scheduler/features/today_task/provider/today_tasks_notifier.dart';

import '../../../core/repos/task_repo.dart';

final todayTasksNotifierProvider =
    StateNotifierProvider<TodayTasksNotifier, TodayTaskState>((ref) {
  final taskRepo = ref.read(taskRepositoryProvider);

  return TodayTasksNotifier(taskRepo);
});
