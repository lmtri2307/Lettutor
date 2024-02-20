import 'package:lettutor/models/User.dart';

class UserService {
  const UserService();

  Future<User> updateAvatar(User user, String path) async {
    await Future.delayed(const Duration(seconds: 2));
    //
    return user;
  }

  Future<UserDetail> getDetail(User user) async {
    await Future.delayed(const Duration(seconds: 2));
    return UserDetail(
        phoneNumber: PhoneNumber(
      phoneNumber: "842499996508",
      isVerified: true,
    ));
  }

  Future<void> updateDetail(User user) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
