import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/db/task_hive_db.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';

class TaskRepo {
  // Initialize TaskHive instance
  final TaskHiveDB taskHiveDB;

  TaskRepo(this.taskHiveDB);

  // Save task
  Future<void> saveTaskDetails(TaskModel taskModel) async {
    await taskHiveDB.saveTask(taskModel);
  }

// Get all task
  List<TaskModel>? getAllTasks() {
    return taskHiveDB.getAllTasks();
  }

// Clear tasks
  Future<void> clearTaskDetails() async {
    await taskHiveDB.clearUser();
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    await taskHiveDB.deleteTask(id);
  }
}

// Task Repository Provider
final taskRepositoryProvider = Provider<TaskRepo>((ref) {
  final taskHiveDB = ref.read(taskHiveDBProvider);

  return TaskRepo(taskHiveDB);
});
