import 'package:flutter/material.dart';
import 'package:task_scheduler/features/onboarding_page/presentation/widgets/onboarding_screen_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingScreenWidgets(),
    );
  }
}
