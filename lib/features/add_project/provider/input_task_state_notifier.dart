import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/repos/task_repo.dart';
import 'package:task_scheduler/features/add_project/provider/task_input_state.dart';
import 'package:uuid/uuid.dart';

class InputTaskStateNotifier extends StateNotifier<TaskInputState> {
  final TaskRepo taskRepo;

  // To create unique uid
  final Uuid _uuid = const Uuid();
  InputTaskStateNotifier(this.taskRepo) : super(TaskInputState()) {
    _loadTasks();
  }
  // Update task Group
  void onTaskGroupSelected(String taskGroup) {
    state = state.copyWith(taskGroup: taskGroup);
  }

  // Update task Group
  void onTaskGroupIconSelected(String taskIcon) {
    state = state.copyWith(taskIcon: taskIcon);
  }

  // Update task name
  void onTaskNameUpdated(String taskName) {
    state = state.copyWith(taskName: taskName);
  }

  // Update task description
  void onTaskDescriptionUpdated(String taskDescription) {
    state = state.copyWith(taskDescription: taskDescription);
  }

  // Update start date
  void updateStartTime(String startTime) {
    state = state.copyWith(startTime: startTime);
  }

  // Update start time
  void updateStartDate(String startDate) {
    state = state.copyWith(startDate: startDate);
  }

  // Update end date
  void updateEndDate(String endDate) {
    state = state.copyWith(endDate: endDate);
  }

  // Update end time
  void updateEndTime(String endTime) {
    state = state.copyWith(endTime: endTime);
  }

  // Save task details
  Future<void> saveTaskDetails() async {
    final taskModel = TaskModel(
      // Generate unique ID
      id: _uuid.v4(),
      taskGroup: state.taskGroup,
      taskIcon: state.taskIcon,
      taskName: state.taskName,
      taskDescription: state.taskDescription,
      startDate: state.startDate,
      startTime: state.startTime,
      endDate: state.endDate,
      endTime: state.endTime,
    );
    log('State before saving from the notifier: $taskModel');
    await taskRepo.saveTaskDetails(taskModel);

    // After saving, reload all tasks and update the state
    final allTasks = await taskRepo.getAllTasks();
    state = state.copyWith(tasks: allTasks);

    log("All tasKs from the notifier: ${taskRepo.getAllTasks()}");
  }

  Future<void> _loadTasks() async {
    final allTasks = await taskRepo.getAllTasks();
    state = state.copyWith(tasks: allTasks);
  }

  // // Get task from HiveDB
  Future<List<TaskModel>?> loadAllTasks() async {
    return taskRepo.getAllTasks();
  }
}
