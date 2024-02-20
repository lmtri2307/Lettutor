class User {
  User(
      {required this.email,
      required this.id,
      this.name,
      this.avatar,
      this.password,
      this.detail});

  String id;
  String email;
  String? name;
  String? avatar;
  String? password;
  UserDetail? detail;
}

class UserDetail {
  String? country;
  PhoneNumber phoneNumber;
  DateTime? birthday;

  UserDetail({this.country, required this.phoneNumber, this.birthday});
}

class PhoneNumber {
  String? phoneNumber;
  bool isVerified;

  PhoneNumber({this.phoneNumber, this.isVerified = false});
}
