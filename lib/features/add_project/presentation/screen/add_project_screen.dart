import 'package:flutter/material.dart';
import 'package:task_scheduler/features/add_project/presentation/widgets/add_project_widgets.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AddProjectWidgets(),
    );
  }
}
