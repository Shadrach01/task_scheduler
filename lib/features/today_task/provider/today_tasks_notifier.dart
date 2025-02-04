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
    log('SelectedDate: $selectedDate, stateDate: ${state.selectedDate}');
    // filterTasksByDateAndStatus();
    loadTasks();
  }

  void updateSelectedButtonStatus(String selectedButton) {
    state = state.copyWith(selectedStatus: selectedButton);
  }

  List<TaskModel> _filterTasksByDate() {
    DateTime selectedDate = state.selectedDate;

    log("Filtering tasks by SelectedDate: $selectedDate");

    var tasks = state.tasks;

    final selectedTask = tasks.where((task) {
      // Parsing the dateTime
      final DateTime startDay = DateFormat('dd MMM yyyy').parse(task.startDay);
      return startDay.year == selectedDate.year &&
          startDay.month == selectedDate.month &&
          startDay.day == selectedDate.day;
    }).toList();
    _filterTasksByStatus();
    // filterTasksByDateAndStatus();

    return selectedTask;
  }

  List<TaskModel> filterTasksByDateAndStatus() {
    var tasksByDate = _filterTasksByDate();

    String selectedStatus = state.selectedStatus;

    log("Filtering tasks b selectedStatus: $selectedStatus");

    if (selectedStatus == 'All') {
      return tasksByDate;
    }

    return tasksByDate.where((task) => task.status == selectedStatus).toList();
  }

  // Filter tasks by selected date and status
  List<TaskModel> _filterTasksByStatus() {
    String selectedStatus = state.selectedStatus;

    log("SelectedStatus: $selectedStatus");
    var tasks = state.tasks;

    // If buttonText is "All", return all tasks
    if (selectedStatus == "All") {
      return tasks;
    }
    // Otherwise, filter tasks based on the status matching the buttonText
    return tasks.where((task) => task.status == selectedStatus).toList();
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
    log("Statuses: $updatedTasks");

    state = state.copyWith(tasks: updatedTasks);
  }

  Future<void> loadTasks() async {
    final allTasks = taskRepo.getAllTasks();
    state = state.copyWith(tasks: allTasks);
    _filterTasksByStatus(); // Filter tasks immediately after loading them
    _filterTasksByDate(); // Filter tasks by date immediately after loading them
  }
}
