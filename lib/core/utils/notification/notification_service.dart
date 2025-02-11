import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/features/notification_page/provider/notified_tasks_notifier.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../models/task_model/task_model.dart';

class NotificationService {
  // Initialize the FlutterLocalNotifications plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Reference to the NotifiedTasksNotifier
  static late NotifiedTasksNotifier _notifiedTasksNotifier;

  // Map to store tasks by their notification IDs
  static final Map<int, TaskModel> _taskNotifications = {};
  static final Map<int, TaskModel> _endedTaskNotifications = {};

  static void registerNotifier(NotifiedTasksNotifier notifier) {
    _notifiedTasksNotifier = notifier;
    log('NotifiedTasksNotifier registered');
  }

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {
    final int id = notificationResponse.id ?? -1;

    // Check if this is a task start notification
    if (_taskNotifications.containsKey(id)) {
      log('Found start notification for task id: $id');
      final task = _taskNotifications[id]!;
      _notifiedTasksNotifier.addStartedTask(task);
      log('Started tasks count: ${_notifiedTasksNotifier?.state.startedTasks.length}');
    }

    // Check if this is a task end notification
    if (_endedTaskNotifications.containsKey(id)) {
      log('Found end notification for task id: $id');
      final task = _endedTaskNotifications[id]!;
      _notifiedTasksNotifier.addEndedTask(task);
      log('Ended tasks count: ${_notifiedTasksNotifier?.state.endedTasks.length}');
    }
  }

// Initialize the notification plugin
  static Future<void> init() async {
    // Define the Android initialization settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    // Define the iOS initialization settings
    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    // Combine Android and iOS initialization settings
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    // Initialize the plugin with the specified settings
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    // Request notification permission from android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

// A list to hold every unique Id for each alarm scheduled
  static final List<int> _uniqueNotificationIds = [];

  static final List<int> _finishedUniqueNotificationIds = [];

  // Show a scheduled Notification according to the set task time
  static Future<void> scheduleNotification(
    TaskModel task,
    DateTime scheduledDate,
  ) async {
    // Define Notification Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    // Unique Id/ Key for each task notification
    int uniqueNotificationId = UniqueKey().hashCode;

// Store the task with its notification ID
    _taskNotifications[uniqueNotificationId] = task;
    log('Task stored in _taskNotifications map');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      uniqueNotificationId,
      task.taskName,
      task.taskDescription,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    // Add the notification ID to the list of Ids
    _uniqueNotificationIds.add(uniqueNotificationId);
  }

  // Show a scheduled Notification according to the set task time
  static Future<void> scheduleNotificationTaskEnded(
    TaskModel task,
    String body,
    DateTime scheduledDate,
  ) async {
    // Define Notification Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    // Unique Id/ Key for each task finished notification
    int uniqueNotificationId = UniqueKey().hashCode;

    // Store the task with its end notification ID
    _endedTaskNotifications[uniqueNotificationId] = task;
    log('Task stored in _endedTaskNotifications map');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      uniqueNotificationId,
      task.taskName,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );

    // Add the notification ID to the list of Ids of _finishedUniqueNotificationIds
    _finishedUniqueNotificationIds.add(uniqueNotificationId);
  }
}
