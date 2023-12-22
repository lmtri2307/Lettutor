import 'dart:convert';

import 'package:http/http.dart';
import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/User.dart';

class AuthRepository {
  const AuthRepository();

  final baseUrl = "/auth";

  Future<User> login(String username, String password) async {
    final response = await apiClient.post(Uri.parse('$baseUrl/login'), body: {
      'email': username,
      'password': password,
    });
    // final response = await post(
    //     Uri.parse("https://sandbox.api.lettutor.com/auth/login"),
    //     body: {
    //       'email': username,
    //       'password': password,
    //     });
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final user = User(
        id: data['user']['id'],
        email: data["user"]["email"],
        name: data['user']['name'],
        avatar: data['user']['avatar'],
        detail: UserDetail(
            birthday: DateTime.parse(data['user']['birthday']),
            country: data['user']['country'],
            phoneNumber: PhoneNumber(
              phoneNumber: data['user']['phone'],
              isVerified: data['user']['isPhoneActivated'],
            )),
      );
      final accessToken = data['tokens']['access']['token'];
      apiClient.token = accessToken;
      return user;
    }

    throw Exception(data['message']);
  }

  Future<void> signup(String username, String password) async {
    final response = await apiClient.post(Uri.parse('$baseUrl/register'), body: {
      "email": username,
      "password": password,
      "source": 'null',
    });
    final data = json.decode(response.body);
    if(response.statusCode < 200 || response.statusCode > 299){
      throw Exception(data['message']);
    }
  }

  Future<void> resetPassword(String username) async {
    throw UnimplementedError();
  }
}
