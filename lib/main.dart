import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_scheduler/core/db/user_hive_db.dart';

import 'core/db/task_hive_db.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final userHiveDB = UserHiveDB();
  final taskHiveDB = TaskHiveDB();

  // Initialize Hive before app starts
  await userHiveDB.initHive();
  await taskHiveDB.initHive();
  runApp(ProviderScope(child: const MyApp()));
}
