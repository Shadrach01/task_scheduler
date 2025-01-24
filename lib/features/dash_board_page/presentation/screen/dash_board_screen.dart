import 'package:flutter/material.dart';

import '../widgets/dash_board_screen_widgets.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashBoardScreenWidgets(),
    );
  }
}
