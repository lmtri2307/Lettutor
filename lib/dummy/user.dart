import 'package:lettutor/models/User.dart';

final userList = List.generate(
  5,
  (index) => User(
      id: index.toString(),
      email: 'user$index@gmail.com',
      password: "123456",
      name: "User$index"),
);
