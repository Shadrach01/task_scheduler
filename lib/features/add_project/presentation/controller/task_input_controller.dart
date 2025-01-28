import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/features/add_project/provider/task_notifier_provider.dart';

class TaskInputController {
  TaskInputController();

  // Task name controller
  TextEditingController taskNameController = TextEditingController();

// Task details controller
  TextEditingController taskDescriptionController = TextEditingController();

  Future saveTaskToHiveDB(BuildContext context, WidgetRef ref) async {
    // Get the current state
    var state = ref.read(inputTaskDetailsNotifierProvider);

    String taskGroup = state.taskGroup;
    String taskIcon = state.taskIcon;
    String taskName = state.taskName;
    String taskDescription = state.taskDescription;
    String startDate = state.startDate;
    String startTime = state.startTime;
    String endDate = state.endDate;
    String endTime = state.endTime;

    taskNameController.text = taskName;
    taskDescriptionController.text = taskDescription;
    //
    // if (taskGroup.isEmpty || state.taskGroup.isEmpty) {
    //   return AppSnackBar.show(context, message: "Select a task Group");
    // }
    //
    // if (taskName.isEmpty || state.taskName.isEmpty) {
    //   return AppSnackBar.show(context, message: "Give your task a name");
    // }
    //
    // if (taskDescription.isEmpty || state.taskDescription.isEmpty) {
    //   return AppSnackBar.show(context, message: "Description cannot be empty");
    // }

    await ref.read(inputTaskDetailsNotifierProvider.notifier).saveTaskDetails();
  }
}
