import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../repository/auth/repository/simple_user.dart';

class AuthNotifier extends StateNotifier<SimpleUser?> {

  AuthNotifier() : super(null) {
    _loadCurrentUser();
  }

  final Box<SimpleUser> _userBox = Hive.box<SimpleUser>('User_Box');

  void _loadCurrentUser() {
    if (_userBox.isNotEmpty) {
      state = _userBox.values.first;
    }
  }

  Future<bool> signUp(SimpleUser user) async {
    try {
      await _userBox.put(user.email.toLowerCase().trim(), user);
      state = user;
      return true;
    } catch (e) {
      print('Error during signup: $e');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final user = _userBox.get(email.toLowerCase().trim());
      if (user != null && user.password == password) {
        state = user;
        return true;
      }
      return false;
    } catch (e) {
      print('Error during signin: $e');
      return false;
    }
  }

  void signOut() {
    state = null;
  }

  bool get isAuthenticated => state != null;
  SimpleUser? get currentUser => state;
}

final authProvider = StateNotifierProvider<AuthNotifier, SimpleUser?>((ref) {
  return AuthNotifier();
});


