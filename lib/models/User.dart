class User {
  User({required this.email, required this.id, this.name, this.avatar, this.password});

  String id;
  String email;
  String? name;
  String? avatar;
  String? password;
}
