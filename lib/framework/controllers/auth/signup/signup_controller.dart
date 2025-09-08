import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../repository/dashbord/repository/dashboard_provider.dart';
import '../auth_service.dart';

class SignUpController {
  static void addUser(SimpleUser user) async {
    await AuthService.storeUser(user);
  }

  Future<String> checkUser(String email, String password) async {
    return AuthService.authenticateUser(email, password);
  }

  void addAllData(WidgetRef ref) async {
    await ref.read(dashboardProvider.notifier).addAllData();
    LoggingDetail.isLogged= ref.read(authProvider.notifier).isAuthenticated;
  }
}
