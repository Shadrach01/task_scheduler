import 'package:flutter/material.dart';
import 'package:task_scheduler/features/today_task/presentation/widgets/today_task_widgets.dart';

class TodayTaskScreen extends StatelessWidget {
  const TodayTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TodayTaskWidgets(),
    );
  }
}
