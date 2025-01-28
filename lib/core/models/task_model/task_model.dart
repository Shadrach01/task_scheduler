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
  final String taskName;

  @HiveField(4)
  final String taskDescription;

  @HiveField(5)
  final String startDate;

  @HiveField(6)
  final String startTime;

  @HiveField(7)
  final String endDate;

  @HiveField(8)
  final String endTime;

  const TaskModel({
    required this.id,
    required this.taskGroup,
    required this.taskIcon,
    required this.taskName,
    required this.taskDescription,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
  });

  @override
  String toString() {
    return 'UserDetails(id: $id, taskGroup: $taskGroup, taskIcon: $taskIcon, '
        'taskName: $taskName, taskDescription, '
        'startDate: $startDate, startTime: $startTime, endDate: $endDate, '
        'endTime: $endTime';
  }
}
