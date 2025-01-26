import 'package:task_scheduler/core/db/user_hive_db.dart';
import 'package:task_scheduler/core/models/user_details.dart';

class UserRepository {
  final UserHiveDB userHiveDB;

  UserRepository(this.userHiveDB);

  // Save User details
  Future<void> saveUserDetails(UserDetails userDetails) async {
    await userHiveDB.saveUser(userDetails);
  }

  // Get user details
  Future<UserDetails?> getUserDetails(String userId) async {
    return await userHiveDB.getUser(userId);
  }

  // Clear user data
  Future<void> clearUserDetails() async {
    await userHiveDB.clearUser();
  }
}
