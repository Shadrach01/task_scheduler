import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_scheduler/core/models/user_details.dart';
import 'package:task_scheduler/core/repos/userRepository.dart';

import 'input_user_state.dart';

class InputUserNotifier extends StateNotifier<InputUserState> {
  final UserRepository userRepository;
  InputUserNotifier(this.userRepository) : super(InputUserState());

  // Update user name
  void onUserNameChanged(String userName) {
    state = state.copyWith(userName: userName);
  }

  // Update profile picture
  void onProfilePictureChanged(String profilePicture) {
    state = state.copyWith(profilePicture: profilePicture);
  }

  // Save user data to HiveDB
  Future<void> saveUserDetails() async {
    final userDetails = UserDetails(
      id: 'user_id_1',
      name: state.userName,
      profilePicture: state.profilePicture,
    );

    await userRepository.saveUserDetails(userDetails);

    print(await userRepository.getUserDetails('user_id_1'));
  }

  // Get User from HiveDB
  Future<void> loadUserDetails() async {
    final userDetails = await userRepository.getUserDetails('user_id_1');

    if (userDetails != null) {
      state = state.copyWith(
        userName: userDetails.name,
        profilePicture: userDetails.profilePicture,
      );
    }
  }
}
