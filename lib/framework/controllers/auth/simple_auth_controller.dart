import 'package:hive/hive.dart';
import '../../repository/auth/repository/simple_user.dart';

class SimpleAuthController {
  static const String _userBoxName = 'User_Box';

  // Store user during signup
  static Future<bool> addUser(SimpleUser user) async {
    try {
      final userBox = Hive.box<SimpleUser>(_userBoxName);
      await userBox.put(user.email.toLowerCase().trim(), user);
      print('User stored successfully: ${user.email}');
      return true;
    } catch (e) {
      print('Error storing user: $e');
      return false;
    }
  }

  // Check user credentials during login
  static Future<String> checkUser(String email, String password) async {
    try {
      final userBox = Hive.box<SimpleUser>(_userBoxName);

      if (!userBox.containsKey(email.toLowerCase().trim())) {
        return 'user_not_found';
      }

      final user = userBox.get(email.toLowerCase().trim());
      if (user == null) {
        return 'user_not_found';
      }

      if (user.password == password) {
        return 'login_success';
      } else {
        return 'wrong_password';
      }
    } catch (e) {
      print('Error checking user: $e');
      return 'authentication_error';
    }
  }

  // Get user by email
  static SimpleUser? getUser(String email) {
    try {
      final userBox = Hive.box<SimpleUser>(_userBoxName);
      return userBox.get(email.toLowerCase().trim());
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Check if user exists
  static bool userExists(String email) {
    try {
      final userBox = Hive.box<SimpleUser>(_userBoxName);
      return userBox.containsKey(email.toLowerCase().trim());
    } catch (e) {
      print('Error checking if user exists: $e');
      return false;
    }
  }
}


