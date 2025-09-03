import 'package:hive/hive.dart';
import '../../repository/auth/model/user.dart';

class AuthService {
  static const String _userBoxName = 'User_Box';

  // Get the user box
  static Box<User> get _userBox => Hive.box<User>(_userBoxName);

  // Store user during signup
  static Future<void> storeUser(User user) async {
    try {
      await _userBox.put(user.email.toLowerCase().trim(), user);
      print('User stored successfully: ${user.email}');
    } catch (e) {
      print('Error storing user: $e');
      throw Exception('Failed to store user');
    }
  }

  // Get user by email
  static User? getUser(String email) {
    try {
      return _userBox.get(email.toLowerCase().trim());
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Check if user exists
  static bool userExists(String email) {
    return _userBox.containsKey(email.toLowerCase().trim());
  }

  // Authenticate user during login
  static String authenticateUser(String email, String password) {
    try {
      if (!userExists(email)) {
        return 'user_not_found';
      }

      final user = getUser(email);
      if (user == null) {
        return 'user_not_found';
      }

      if (user.password == password) {
        return 'login_success';
      } else {
        return 'wrong_password';
      }
    } catch (e) {
      print('Error authenticating user: $e');
      return 'authentication_error';
    }
  }

  // Get current logged in user
  static User? getCurrentUser() {
    try {
      // For simplicity, return the first user found
      // In a real app, you'd store the current user's email in shared preferences
      if (_userBox.isNotEmpty) {
        return _userBox.values.first;
      }
      return null;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Clear all users (for testing/debugging)
  static Future<void> clearAllUsers() async {
    try {
      await _userBox.clear();
      print('All users cleared');
    } catch (e) {
      print('Error clearing users: $e');
    }
  }
}


