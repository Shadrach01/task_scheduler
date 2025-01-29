import 'package:flutter/material.dart';

class TaskInputState {
  final String taskGroup;
  final String taskIcon;
  final Color taskGroupColor;
  final String taskName;
  final String taskDescription;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final String status;

  TaskInputState({
    this.taskGroup = '',
    this.taskIcon = '',
    this.taskGroupColor = Colors.transparent,
    this.taskName = '',
    this.taskDescription = '',
    this.startDate = '',
    this.startTime = '',
    this.endDate = '',
    this.endTime = '',
    this.status = '',
  });

  TaskInputState copyWith({
    String? taskGroup,
    String? taskIcon,
    Color? taskGroupColor,
    String? taskName,
    String? taskDescription,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    String? status,
  }) {
    return TaskInputState(
      taskGroup: taskGroup ?? this.taskGroup,
      taskIcon: taskIcon ?? this.taskIcon,
      taskGroupColor: taskGroupColor ?? this.taskGroupColor,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }
}
