import 'package:task_scheduler/core/db/task_hive_db.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';

class TaskRepo {
  // Initialize TaskHive instance
  final TaskHiveDB taskHiveDB;

  TaskRepo(this.taskHiveDB);

  // Save task
  Future<void> saveTaskDetails(TaskModel taskModel) async {
    print("save task called from the repo: ${taskModel.toString()}");
    await taskHiveDB.saveTask(taskModel);
  }

// Get all task
  List<TaskModel>? getAllTasks() {
    print("get task called from the repo: ${taskHiveDB.getAllTasks()}");
    return taskHiveDB.getAllTasks();
  }

// Clear tasks
  Future<void> clearTaskDetails() async {
    await taskHiveDB.clearUser();
  }
}
