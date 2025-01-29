import 'package:task_scheduler/core/models/task_model/task_model.dart';

class TodayTaskState {
  final List<TaskModel> tasks;

  const TodayTaskState({
    this.tasks = const [],
  });

  TodayTaskState copyWith({
    List<TaskModel>? tasks,
  }) {
    return TodayTaskState(
      tasks: tasks ?? this.tasks,
    );
  }
}
