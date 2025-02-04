import 'dart:ui';

import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 2)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String taskGroup;

  @HiveField(2)
  final String taskIcon;

  @HiveField(3)
  final int taskGroupColor;

  @HiveField(4)
  final String taskName;

  @HiveField(5)
  final String taskDescription;

  @HiveField(6)
  final String startDay;

  @HiveField(7)
  final String startTime;

  @HiveField(8)
  final String endDay;

  @HiveField(9)
  final String endTime;

  @HiveField(10)
  final String status;

  const TaskModel({
    required this.id,
    required this.taskGroup,
    required this.taskIcon,
    required this.taskGroupColor,
    required this.taskName,
    required this.taskDescription,
    required this.startDay,
    required this.startTime,
    required this.endDay,
    required this.endTime,
    required this.status,
  });

  /// Helper method to convert an integer to a Color
  Color get color => Color(taskGroupColor);

  /// Helper method to save a Color as an integer
  static int colorToInt(Color color) => color.value;

  @override
  String toString() {
    return 'UserDetails(id: $id, taskGroup: $taskGroup, taskIcon: $taskIcon, '
        'taskGroupColor: $taskGroupColor, taskName: $taskName, taskDescription: $taskDescription, '
        'startDate: $startDay, startTime: $startTime, endDate: $endDay, '
        'endTime: $endTime, status: $status)';
  }

  TaskModel copyWith({
    String? id,
    String? taskGroup,
    String? taskIcon,
    int? taskGroupColor,
    String? taskName,
    String? taskDescription,
    String? startDay,
    String? startTime,
    String? endDay,
    String? endTime,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskGroup: taskGroup ?? this.taskGroup,
      taskIcon: taskIcon ?? this.taskIcon,
      taskGroupColor: taskGroupColor ?? this.taskGroupColor,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      startDay: startDay ?? this.startDay,
      startTime: startTime ?? this.startTime,
      endDay: endDay ?? this.endDay,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }
}
