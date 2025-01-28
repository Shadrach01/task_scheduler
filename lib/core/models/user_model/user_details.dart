import 'package:hive/hive.dart';

part 'user_details.g.dart';

@HiveType(typeId: 1)
class UserDetails {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String profilePicture;

  const UserDetails({
    required this.id,
    required this.name,
    required this.profilePicture,
  });

  // Override toString to provide a better debug output
  @override
  String toString() {
    return 'UserDetails(id: $id, name: $name, profilePicture: $profilePicture)';
  }
}
