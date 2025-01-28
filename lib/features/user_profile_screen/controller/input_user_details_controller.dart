import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/notifier_provider.dart';

class InputUserDetailsController {
  InputUserDetailsController();

  // Username text field controller
  TextEditingController userNameController = TextEditingController();

  Future pickImage(WidgetRef ref) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      ref
          .read(inputUserDetailsNotifierProvider.notifier)
          .onProfilePictureChanged(pickedImage.path);
    }
  }

  Future saveUserDetailsToHive(WidgetRef ref) async {
    await ref.read(inputUserDetailsNotifierProvider.notifier).saveUserDetails();
  }

  // Load user details from Hive
  Future loadUserDetailsFromHive(WidgetRef ref) async {
    await ref.read(inputUserDetailsNotifierProvider.notifier).loadUserDetails();
  }
}
