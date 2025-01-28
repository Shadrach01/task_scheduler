import 'package:flutter/material.dart';
import 'package:task_scheduler/features/all_tasks/presentation/widgets/all_tasks_screen_widgets.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AllTasksScreenWidgets(),
    );
  }
}
