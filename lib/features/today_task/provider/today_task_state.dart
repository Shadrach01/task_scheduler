import 'package:task_scheduler/core/models/task_model/task_model.dart';

class TodayTaskState {
  final List<TaskModel> tasks;

  final String selectedStatus;
  final DateTime selectedDate;

  TodayTaskState({
    this.tasks = const [],
    this.selectedStatus = 'All',
    DateTime? selectedDate,
  }) : selectedDate = selectedDate ?? DateTime.now();

  TodayTaskState copyWith({
    List<TaskModel>? tasks,
    String? selectedStatus,
    DateTime? selectedDate,
  }) {
    return TodayTaskState(
      tasks: tasks ?? this.tasks,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
