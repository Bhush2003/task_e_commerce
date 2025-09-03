import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repository/auth/model/user.dart';
import '../../../repository/dashbord/repository/dashboard_provider.dart';
import '../auth_service.dart';

class SignUpController {
  static void addUser(User user) async {
    try {
      await AuthService.storeUser(user);
      print("User added successfully: ${user.email}");
    } catch (e) {
      print("Error adding user: $e");
      throw Exception('Failed to add user');
    }
  }

  Future<String> checkUser(String email, String password) async {
    try {
      return AuthService.authenticateUser(email, password);
    } catch (e) {
      print("Error checking user: $e");
      return 'authentication_error';
    }
  }

  void addAllData(WidgetRef ref) async {
    await ref.read(dashboardProvider.notifier).addAllData();
  }
}
