import 'package:flutter/material.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

class AppButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? color;

  const AppButton({
    super.key,
    required this.child,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue.shade900,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        fixedSize: Size(context.appWidth, context.appHeight * .06),
        side: BorderSide.none,
      ),
      child: child,
    );
  }
}
