import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/repos/task_repo.dart';
import 'package:task_scheduler/features/today_task/provider/today_task_state.dart';

import '../../../core/utils/constants.dart';

class TodayTasksNotifier extends StateNotifier<TodayTaskState> {
  final TaskRepo taskRepo;
  Timer? _timer;
  TodayTasksNotifier(this.taskRepo) : super(TodayTaskState()) {
    loadTasks();
    _startStatusUpdateTime();
  }

  DateTime selectedDate = DateTime.now();

  void updateSelectedDate(DateTime selectedDate) {
    state = state.copyWith(selectedDate: selectedDate);
  }

  void updateSelectedButtonStatus(String selectedButton) {
    state = state.copyWith(selectedStatus: selectedButton);
  }

  List<TaskModel> _filterTasksByDate() {
    DateTime selectedDate = state.selectedDate;

    var tasks = state.tasks;

    final selectedTask = tasks.where((task) {
      // Parsing the dateTime
      final DateTime startDay = DateFormat('dd MMM yyyy').parse(task.startDay);
      return startDay.year == selectedDate.year &&
          startDay.month == selectedDate.month &&
          startDay.day == selectedDate.day;
    }).toList();

    return selectedTask;
  }

  List<TaskModel> filterTasksByDateAndStatus() {
    var tasksByDate = _filterTasksByDate();

    String selectedStatus = state.selectedStatus;

    if (selectedStatus == 'All') {
      return tasksByDate;
    }

    return tasksByDate.where((task) => task.status == selectedStatus).toList();
  }

  void _startStatusUpdateTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTaskStatuses();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Update task statuses
  void _updateTaskStatuses() {
    final currentDateTime = DateTime.now();
    final updatedTasks = state.tasks.map((task) {
      // Parsing start and end dates
      final DateTime startDate = DateFormat('dd MMM yyyy').parse(task.startDay);
      final DateTime startTime = DateFormat('hh:mm a').parse(task.startTime);
      final DateTime startDateTime = DateTime(startDate.year, startDate.month,
          startDate.day, startTime.hour, startTime.minute);
      final DateTime endDate = DateFormat('dd MMM yyyy').parse(task.endDay);
      final DateTime endTime = DateFormat('hh:mm a').parse(task.endTime);
      final DateTime endDateTime = DateTime(endDate.year, endDate.month,
          endDate.day, endTime.hour, endTime.minute);

      // Check current time against task times
      if (startDateTime.isAfter(currentDateTime)) {
        return task.copyWith(status: Constants.tasksStatus[1]); // Not Started
      } else if (startDateTime.isBefore(currentDateTime) &&
          endDateTime.isAfter(currentDateTime)) {
        return task.copyWith(status: Constants.tasksStatus[2]); // In Progress
      } else {
        return task.copyWith(status: Constants.tasksStatus[3]); // Completed
      }
    }).toList();

    state = state.copyWith(tasks: updatedTasks);
  }

  Future<void> loadTasks() async {
    final allTasks = taskRepo.getAllTasks();
    state = state.copyWith(tasks: allTasks);
  }

  // Delete task
  Future<void> deleteTask(String id) async {
    // Delete from the database
    await taskRepo.deleteTask(id);

    // Update the state by filtering out the deleted task
    final updateTasks = state.tasks.where((task) => task.id != id).toList();
    state = state.copyWith(tasks: updateTasks);

    log("Tasks after deleting: ${state.tasks}");
  }
}
