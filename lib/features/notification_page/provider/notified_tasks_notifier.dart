import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/notification/notification_service.dart';
import 'package:task_scheduler/features/notification_page/provider/notification_state.dart';

class NotifiedTasksNotifier extends StateNotifier<NotifiedTasksState> {
  NotifiedTasksNotifier() : super(NotifiedTasksState()) {
    NotificationService.registerNotifier(this);
  }

  void addStartedTask(TaskModel task) {
    log('Adding task to started tasks: ${task.taskName}');
    state = state.copyWith(
      startedTasks: [...state.startedTasks, task],
    );
    log('Started tasks count after adding: ${state.startedTasks.length}');
  }

  void addEndedTask(TaskModel task) {
    log('Adding task to ended tasks: ${task.taskName}');
    state = state.copyWith(
      endedTasks: [...state.endedTasks, task],
    );
    log('Ended tasks count after adding: ${state.endedTasks.length}');
  }

  void clearStartedTasks() {
    state = state.copyWith(startedTasks: []);
  }

  void clearEndedTasks() {
    state = state.copyWith(endedTasks: []);
  }
}

// Provider
final notifiedTasksProvider =
    StateNotifierProvider<NotifiedTasksNotifier, NotifiedTasksState>(
        (ref) => NotifiedTasksNotifier());
