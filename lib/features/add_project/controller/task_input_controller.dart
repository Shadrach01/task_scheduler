import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/utils/constants.dart';
import 'package:task_scheduler/features/add_project/provider/add_task_notifier_provider.dart';

class AddTaskController {
  final WidgetRef ref;

  AddTaskController(this.ref);

  // Task name controller
  TextEditingController taskNameController = TextEditingController();

// Task details controller
  TextEditingController taskDescriptionController = TextEditingController();

  updateStatus() {
    final status = Constants.tasksStatus[1];
    ref.read(inputTaskDetailsNotifierProvider.notifier).updateStatus(status);
  }

  Future saveTaskToHiveDB(BuildContext context) async {
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
    updateStatus();

    await ref
        .read(inputTaskDetailsNotifierProvider.notifier)
        .saveTaskDetails(ref);
  }
}
