import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/db/user_hive_db.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hiveDB = UserHiveDB();

  // Initialize Hive before app starts
  await hiveDB.initHive();
  runApp(ProviderScope(child: const MyApp()));
}
