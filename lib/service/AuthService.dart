import 'package:lettutor/dummy/user.dart';
import 'package:lettutor/models/User.dart';

class AuthService {
  const AuthService();

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    return userList.firstWhere(
        (element) => element.email == email && element.password == password);
  }

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    if (userList.map((user) => user.email).contains(email)) {
      throw Exception("Email has been used");
    }

    userList.add(User(email: email, password: password));
  }

  Future<void> resetPassword(String email) async {
    userList.firstWhere((element) => element.email == email);
  }
}
