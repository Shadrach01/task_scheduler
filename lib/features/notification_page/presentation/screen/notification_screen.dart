import 'package:flutter/material.dart';
import 'package:task_scheduler/features/notification_page/presentation/widgets/notification_screen_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NotificationScreenWidgets(),
    );
  }
}
