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
  final String startDate;

  @HiveField(7)
  final String startTime;

  @HiveField(8)
  final String endDate;

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
    required this.startDate,
    required this.startTime,
    required this.endDate,
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
        'taskGroupColor: $taskGroupColor, taskName: $taskName, taskDescription, '
        'startDate: $startDate, startTime: $startTime, endDate: $endDate, '
        'endTime: $endTime, status: $status)';
  }
}
