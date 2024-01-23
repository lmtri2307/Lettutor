import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';

class UserRepository {
  const UserRepository();

  final baseUrl = '/user';

  Future<Duration> getTotalLessonTime() async {
    final response = await apiClient.get(Uri.parse("/call/total"));
    final data = json.decode(response.body);

    return Duration(minutes: data['total']);
  }
}
