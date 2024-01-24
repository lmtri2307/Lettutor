import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:lettutor/service/UserService.dart';

class AuthProvider extends ChangeNotifier {
  bool get isLoggedIn => user != null;
  User? user;
  final _userService = const UserService();
  final _authService = const AuthService();

  AuthProvider({this.user});

  void setUser(User? user) {
    if (this.user != user) {
      this.user = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    user = null;
    await _authService.logout();
    notifyListeners();
  }

  Future<void> updateAvatar(String path) async {
    await _userService.updateAvatar(user!, path);
  }
}
