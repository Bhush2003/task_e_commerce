import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:hive/hive.dart';

class AuthService {
  static const String _userBoxName = 'User_Box';

  static Box<SimpleUser> get _userBox => Hive.box<SimpleUser>(_userBoxName);

  static Future<void> storeUser(SimpleUser user) async {

      await _userBox.put(user.email.toLowerCase().trim(), user);


  }

  static SimpleUser? getUser(String email) {

      return _userBox.get(email.toLowerCase().trim());

  }

  // Check if user exists
  static bool userExists(String email) {
    return _userBox.containsKey(email.toLowerCase().trim());
  }

  // Authenticate user during login
  static String authenticateUser(String email, String password) {

      if (!userExists(email)) {
        return 'user_not_found';
      }

      final user = getUser(email);
      if (user == null) {
        return 'user_not_found';
      }

      if (user.password.toString().trim() == password.toString().trim()) {
        LoggingDetail.isGuest=false;
        return 'login_success';

      } else {
        return 'wrong_password';
      }

  }

  static SimpleUser? getCurrentUser() {
     if (_userBox.isNotEmpty) {
        return _userBox.values.first;
      }
      return null;
  }

  static Future<void> clearAllUsers() async {
      await _userBox.clear();
  }
}


