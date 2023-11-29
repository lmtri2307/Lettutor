import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/User.dart';

class AuthProvider extends ChangeNotifier {
  bool get isLoggedIn => user != null;
  User? user;

  AuthProvider({this.user});

  void setUser(User? user) {
    if (this.user != user) {
      this.user = user;
      notifyListeners();
    }
  }
}
