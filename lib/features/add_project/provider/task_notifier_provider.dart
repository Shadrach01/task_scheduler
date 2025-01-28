// Task Hive DB
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/db/task_hive_db.dart';
import 'package:task_scheduler/core/repos/task_repo.dart';
import 'package:task_scheduler/features/add_project/provider/input_task_state_notifier.dart';
import 'package:task_scheduler/features/add_project/provider/task_input_state.dart';

final taskHiveDBProvider = Provider<TaskHiveDB>((ref) => TaskHiveDB());

// Task Repository Provider
final taskRepositoryProvider = Provider<TaskRepo>((ref) {
  final taskHiveDB = ref.read(taskHiveDBProvider);
  print("task repo called from the provider: $taskHiveDB");
  return TaskRepo(taskHiveDB);
});

// Input Task Notifier Provider
final inputTaskDetailsNotifierProvider =
    StateNotifierProvider<InputTaskStateNotifier, TaskInputState>((ref) {
  final taskRepo = ref.read(taskRepositoryProvider);
  print("task inout details called from the provider: $taskRepo");
  return InputTaskStateNotifier(taskRepo);
});
