import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/repository/AuthRepository.dart';

class AuthService {
  final authRepository = const AuthRepository();

  const AuthService();

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    return await authRepository.login(email, password);
  }

  Future<User?> loginWithGoogle() async {
    final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleSignIn?.authentication;
    final String? accessToken = googleAuth?.accessToken;
    if(accessToken == null){
      return null;
    }
    return await authRepository.loginWithGoogle(accessToken);
  }

  Future<User?> loginWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    if(loginResult.status != LoginStatus.success){
      return null;
    }
    final String? accessToken = loginResult.accessToken?.token;
    if(accessToken == null){
      return null;
    }
    return await authRepository.loginWithFacebook(accessToken);
  }

  Future<void> signupWithEmailAndPassword(String email, String password) async {
    try {
      return await authRepository.signup(email, password);
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<User> refreshSession() async {
    try {
      return await authRepository.refresh();
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    return await authRepository.resetPassword(email);
  }

  Future<void> logout() async {
    await authRepository.logout();
  }
}
