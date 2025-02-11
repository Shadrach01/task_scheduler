import 'package:task_scheduler/core/models/task_model/task_model.dart';

class NotifiedTasksState {
  List<TaskModel> startedTasks;
  List<TaskModel> endedTasks;

  NotifiedTasksState({
    this.startedTasks = const [],
    this.endedTasks = const [],
  });

  NotifiedTasksState copyWith({
    List<TaskModel>? startedTasks,
    List<TaskModel>? endedTasks,
  }) {
    return NotifiedTasksState(
      startedTasks: startedTasks ?? this.startedTasks,
      endedTasks: endedTasks ?? this.endedTasks,
    );
  }
}
