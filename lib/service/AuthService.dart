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
    final lastUser = userList.last;
    userList.add(User(
      id: (int.tryParse(lastUser.id)! + 1).toString(),
      email: email,
      password: password,
      name: email.substring(0, email.indexOf("@")),
    ));
  }

  Future<void> resetPassword(String email) async {
    userList.firstWhere((element) => element.email == email);
  }
}
