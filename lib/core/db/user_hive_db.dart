// HIVE DB FOR USER DETAILS
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_scheduler/core/models/user_model/user_details.dart';

class UserHiveDB {
  static final UserHiveDB _instance = UserHiveDB._internal();
  factory UserHiveDB() => _instance;
  UserHiveDB._internal();

  static const String userBoxName = 'userBox';

  // Open Hive box
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDetailsAdapter());

    await Hive.openBox(userBoxName);
  }

  // Save user data
  Future<void> saveUser(UserDetails userDetails) async {
    final box = await Hive.openBox(userBoxName);
    return box.put(userDetails.id, userDetails);
  }

  // Get user data
  Future<UserDetails?> getUser(String userId) async {
    final box = await Hive.openBox(userBoxName);
    return box.get(userId);
  }

  // Clear all saved data
  Future<void> clearUser() async {
    final box = await Hive.openBox(userBoxName);
    await box.clear();
  }
}
