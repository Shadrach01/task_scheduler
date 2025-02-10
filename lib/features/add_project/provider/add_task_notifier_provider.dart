// Task Hive DB
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/repos/task_repo.dart';
import 'package:task_scheduler/features/add_project/provider/add_task_state.dart';
import 'package:task_scheduler/features/add_project/provider/add_task_state_notifier.dart';

// Input Task Notifier Provider
final inputTaskDetailsNotifierProvider =
    StateNotifierProvider<InputTaskStateNotifier, TaskInputState>((ref) {
  final taskRepo = ref.read(taskRepositoryProvider);
  // final notificationService = ref.read(notificationServiceProvider);

  return InputTaskStateNotifier(taskRepo);
});
