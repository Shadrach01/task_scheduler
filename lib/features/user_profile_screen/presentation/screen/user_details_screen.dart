import 'package:flutter/material.dart';

import '../widgets/user_screen_widgets.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileWidgets(),
    );
  }
}
