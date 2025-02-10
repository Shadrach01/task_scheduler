import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../models/task_model/task_model.dart';

class NotificationService {
  // Initialize the FlutterLocalNotifications plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveNotification(
      NotificationResponse notificationResponse) async {}

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
    String title,
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

    await flutterLocalNotificationsPlugin.zonedSchedule(
      uniqueNotificationId,
      title,
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
