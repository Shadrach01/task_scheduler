import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/db/user_hive_db.dart';
import 'package:task_scheduler/core/repos/user_repository.dart';

import 'input_user_notifier.dart';
import 'input_user_state.dart';

// User Hive DB provider
final userHiveDBProvider = Provider<UserHiveDB>((ref) {
  return UserHiveDB(); // Providing instance of UserHiveDB
});

// User Repository provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userHiveDB = ref.read(userHiveDBProvider);

  return UserRepository(userHiveDB);
});

// InputUserNotifier provider
final inputUserDetailsNotifierProvider =
    StateNotifierProvider<InputUserNotifier, InputUserState>(
  (ref) {
    final userRepository = ref.read(userRepositoryProvider);

    return InputUserNotifier(userRepository);
  },
);
