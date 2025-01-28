class TaskInputState {
  final String taskGroup;
  final String taskIcon;
  final String taskName;
  final String taskDescription;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;

  TaskInputState({
    this.taskGroup = '',
    this.taskIcon = '',
    this.taskName = '',
    this.taskDescription = '',
    this.startDate = '',
    this.startTime = '',
    this.endDate = '',
    this.endTime = '',
  });

  TaskInputState copyWith({
    String? taskGroup,
    String? taskIcon,
    String? taskName,
    String? taskDescription,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
  }) {
    return TaskInputState(
      taskGroup: taskGroup ?? this.taskGroup,
      taskIcon: taskIcon ?? this.taskIcon,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
    );
  }
}
