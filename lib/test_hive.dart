import 'package:hive/hive.dart';
import 'framework/repository/auth/model/simple_user.dart';

class HiveTest {
  static Future<void> testHive() async {
    try {
      print('Testing Hive functionality...');

      // Test storing a user
      final testUser = SimpleUser(
        userId: '#12345',
        email: 'test@example.com',
        password: 'password123',
        imagePath: '/path/to/image.jpg',
      );

      final userBox = Hive.box<SimpleUser>('User_Box');
      await userBox.put(testUser.email, testUser);
      print('User stored successfully');

      // Test retrieving the user
      final retrievedUser = userBox.get(testUser.email);
      if (retrievedUser != null) {
        print('User retrieved successfully: ${retrievedUser.email}');
      } else {
        print('Failed to retrieve user');
      }

      // Test checking if user exists
      final exists = userBox.containsKey(testUser.email);
      print('User exists: $exists');

      // Clean up
      await userBox.delete(testUser.email);
      print('Test completed successfully');
    } catch (e) {
      print('Hive test failed: $e');
    }
  }
}


