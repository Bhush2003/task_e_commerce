import 'package:hive/hive.dart';
part 'simple_user.g.dart';

@HiveType(typeId: 1)
class SimpleUser {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String imagePath;

  const SimpleUser({
    required this.userId,
    required this.email,
    required this.password,
    required this.imagePath,
  });

  @override
  String toString() {
    return 'SimpleUser{userId: $userId, email: $email, password: $password, imagePath: $imagePath}';
  }
}


