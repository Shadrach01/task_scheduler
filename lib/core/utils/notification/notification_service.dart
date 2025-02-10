import 'dart:async';
import 'dart:developer';

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

  // Show an instant Notification
  static Future<void> showInstantNotification(String title, String body) async {
    // Define Notification Details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

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
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      task.taskName,
      task.taskDescription,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
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
    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }
}
