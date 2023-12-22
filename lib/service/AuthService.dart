import 'package:lettutor/dummy/user.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/repository/AuthRepository.dart';

class AuthService {
  final authRepository = const AuthRepository();

  const AuthService();

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await authRepository.login(email, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    try{
      return await authRepository.signup(email, password);
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    return await authRepository.resetPassword(email);
  }
}
