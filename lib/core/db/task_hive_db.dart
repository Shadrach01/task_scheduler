/*

HIVE DB FOR TASKS
 */

import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';

class TaskHiveDB {
  static final TaskHiveDB _instance = TaskHiveDB._internal();
  factory TaskHiveDB() => _instance;
  TaskHiveDB._internal();
  static const String taskBoxName = 'taskBox';
  Box<TaskModel>? _taskBox;

  // Open Hive Box
  Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TaskModelAdapter());

    _taskBox = await Hive.openBox<TaskModel>(taskBoxName);
    log("Task box initialized: ${_taskBox?.isOpen}");
  }

  // Save task data
  Future<void> saveTask(TaskModel taskModel) async {
    await _taskBox?.put(taskModel.id, taskModel);
    log("Saved task with ID: ${taskModel.id}");
  }

  // Get all tasks
  List<TaskModel>? getAllTasks() {
    if (_taskBox == null) {
      throw Exception("Task box is not initialized.");
    }
    return _taskBox?.values.toList();
  }

// Clear saved data
  Future<void> clearUser() async {
    await _taskBox!.clear();
  }
}
