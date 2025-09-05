import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repository/dashbord/repository/dashboard_provider.dart';
import '../auth_service.dart';

class SignUpController {
  static void addUser(SimpleUser user) async {
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
    LoggingDetail.isLogged= ref.read(authProvider.notifier).isAuthenticated;
  }
}
