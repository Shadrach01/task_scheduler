import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/repos/task_repo.dart';
import 'package:task_scheduler/features/today_task/provider/today_task_state.dart';

import '../../../core/models/task_model/task_model.dart';

class TodayTasksNotifier extends StateNotifier<TodayTaskState> {
  final TaskRepo taskRepo;
  TodayTasksNotifier(this.taskRepo) : super(TodayTaskState()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final allTasks = taskRepo.getAllTasks();
    state = state.copyWith(tasks: allTasks);
  }

  //z Get task from HiveDB
  Future<List<TaskModel>?> loadAllTasks() async {
    return taskRepo.getAllTasks();
  }
}
