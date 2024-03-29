import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/helpers/reponse_helper.dart';
import 'package:lettutor/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  const AuthRepository();

  final baseUrl = "/auth";

  Future<void> setRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', token);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    return refreshToken;
  }

  Future<User> login(String username, String password) async {
    final response = await apiClient.post(Uri.parse('$baseUrl/login'), body: {
      'email': username,
      'password': password,
    });
    final data = json.decode(response.body);

    if (hasError(response.statusCode)) {
      throw Exception(data['message']);
    }

    final user = User(
        id: data['user']['id'],
        email: data["user"]["email"],
        name: data['user']['name'],
        avatar: data['user']['avatar']);
    // set access token
    final accessToken = data['tokens']['access']['token'];
    apiClient.token = accessToken;

    // set refresh token
    setRefreshToken(data['tokens']['refresh']['token']);
    return user;
  }

  Future<void> signup(String username, String password) async {
    final response =
        await apiClient.post(Uri.parse('$baseUrl/register'), body: {
      "email": username,
      "password": password,
      "source": "https://sandbox.app.lettutor.com/"
    });
    final data = json.decode(response.body);
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw Exception(data['message']);
    }
  }

  Future<User> refresh() async {
    final token = await getRefreshToken();
    if (token == null) {
      throw Exception("No refresh token");
    }

    final response =
        await apiClient.post(Uri.parse('$baseUrl/refresh-token'), body: {
      "refreshToken": token,
      "timezone": '7',
    });

    final data = json.decode(response.body);

    if (hasError(response.statusCode)) {
      throw Exception(data['message']);
    }

    final user = User(
        id: data['user']['id'],
        email: data["user"]["email"],
        name: data['user']['name'],
        avatar: data['user']['avatar']);
    // set access token
    final accessToken = data['tokens']['access']['token'];
    apiClient.token = accessToken;

    // set refresh token
    setRefreshToken(data['tokens']['refresh']['token']);
    return user;
  }

  Future<void> resetPassword(String email) async {
    final response = await apiClient
        .post(Uri.parse('/user/forgotPassword'), body: {"email": email});

    final data = json.decode(response.body);

    if (hasError(response.statusCode)) {
      throw Exception(data['message']);
    }
  }

  Future<User> loginWithGoogle(String googleAccessToken) async {
    final response = await apiClient.post(Uri.parse('$baseUrl/google'), body: {
      'access_token': googleAccessToken,
    });
    final data = json.decode(response.body);
    if (hasError(response.statusCode)) {
      throw Exception(data['message']);
    }
    final user = User(
        id: data['user']['id'],
        email: data["user"]["email"],
        name: data['user']['name'],
        avatar: data['user']['avatar']);
    // set access token
    final accessToken = data['tokens']['access']['token'];
    apiClient.token = accessToken;

    // set refresh token
    setRefreshToken(data['tokens']['refresh']['token']);
    return user;
  }

  Future<User> loginWithFacebook(String facebookAccessToken) async {
    final response =
        await apiClient.post(Uri.parse('$baseUrl/facebook'), body: {
      'access_token': facebookAccessToken,
    });
    final data = json.decode(response.body);
    if (hasError(response.statusCode)) {
      throw Exception(data['message']);
    }
    final user = User(
        id: data['user']['id'],
        email: data["user"]["email"],
        name: data['user']['name'],
        avatar: data['user']['avatar']);
    // set access token
    final accessToken = data['tokens']['access']['token'];
    apiClient.token = accessToken;

    // set refresh token
    setRefreshToken(data['tokens']['refresh']['token']);
    return user;
  }

  Future<void> logout() async {
    apiClient.token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('refreshToken');
  }
}
