import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:task_scheduler/core/models/task_model/task_model.dart';
import 'package:task_scheduler/core/utils/app_text_style.dart';
import 'package:task_scheduler/core/utils/screen_size.dart';

import '../../../../core/commons/helper/get_icon_data.dart';

class ProjectProgressContainer extends StatefulWidget {
  final TaskModel task;
  const ProjectProgressContainer({super.key, required this.task});

  @override
  State<ProjectProgressContainer> createState() =>
      _ProjectProgressContainerState();
}

class _ProjectProgressContainerState extends State<ProjectProgressContainer>
    with SingleTickerProviderStateMixin {
  late double _currentProgress;
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _currentProgress = _calculateTaskProgress();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animateProgress();
  }

  @override
  void didUpdateWidget(covariant ProjectProgressContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Recalculate progress if the task details change
    if (oldWidget.task != widget.task) {
      _animateProgress();
    }
  }

  void _animateProgress() {
    final newProgress = _calculateTaskProgress();
    _progressAnimation = Tween<double>(
      begin: _currentProgress,
      end: newProgress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));

    _animationController.reset();
    _animationController.forward();
    _currentProgress = newProgress;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _calculateTaskProgress() {
    final now = DateTime.now();

    final startDate = DateFormat('dd MMM yyyy').parse(widget.task.startDay);
    final startTime = DateFormat('hh:mm a').parse(widget.task.startTime);
    final startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    final endDate = DateFormat('dd MMM yyyy').parse(widget.task.endDay);
    final endTime = DateFormat('hh:mm a').parse(widget.task.endTime);
    final endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );

    if (now.isBefore(startDateTime)) return 0.0;
    if (now.isAfter(endDateTime)) return 1.0;

    final totalDuration = endDateTime.difference(startDateTime).inMinutes;
    final elapsedDuration = now.difference(startDateTime).inMinutes;

    return elapsedDuration / totalDuration;
  }

  Color _getProgressColor(double progress) {
    if (progress >= 1.0) {
      return Colors.green;
    } else if (progress > 0.7) {
      return Colors.orange.shade700;
    } else {
      return widget.task.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appHeight = context.appHeight;
    final appWidth = context.appWidth;

    return Container(
      width: appWidth * .6,
      padding: EdgeInsets.symmetric(
        horizontal: appWidth * .04,
        vertical: appHeight * .01,
      ),
      margin: EdgeInsets.only(right: appWidth * .05),
      decoration: BoxDecoration(
        color: widget.task.color.withOpacity(.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.task.taskGroup,
                style: AppTextStyle.textStyle(
                  color: Colors.grey.shade700,
                  size: 15,
                ),
              ),
              Container(
                height: appHeight * .04,
                width: appWidth * .09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.task.color.withOpacity(.3),
                ),
                child: Icon(
                  getIconData(widget.task.taskIcon),
                  color: widget.task.color,
                ),
              ),
            ],
          ),
          Text(
            widget.task.taskName,
            style: AppTextStyle.textStyle(
              size: 20,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(height: appHeight * .02),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return LinearPercentIndicator(
                backgroundColor: Colors.white,
                lineHeight: appHeight * .015,
                percent: _progressAnimation.value.clamp(0.0, 1.0),
                progressColor: _getProgressColor(_progressAnimation.value),
                barRadius: const Radius.circular(10),
              );
            },
          ),
        ],
      ),
    );
  }
}
