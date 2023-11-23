import 'package:flutter/cupertino.dart';
import 'package:lettutor/models/User.dart';

class AuthRepository extends ChangeNotifier {
  bool get isLoggedIn => user != null;
  User? user;

  AuthRepository({this.user});

  void setUser(User? user) {
    if (this.user != user) {
      this.user = user;
      notifyListeners();
    }
  }
}
