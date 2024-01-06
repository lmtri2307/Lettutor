import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Tutor.dart';

class TutorRepository {
  const TutorRepository();
  final baseUrl = '/tutor';

  Future<List<Tutor>> getTutorList(int page, int limit) async {
    // fetch api

    final response = await apiClient
        .get(Uri.parse('$baseUrl/more?perPage=$limit&page=$page'));
    final data = json.decode(response.body);
    // convert to model
    final tutorList = data['tutors']['rows'].map<Tutor>((tutor) => Tutor(
          id: tutor['userId'],
          name: tutor['name'],
          avatar: tutor['avatar'],
          rating: tutor['rating'],
          isFavorite: data['favoriteTutor'].any((favoriteTutor) =>
              favoriteTutor['secondId'] == tutor['userId']),
          specialties: tutor['specialties'],
          // tutor['feedbacks'] is a list of feedbacks
          numOfReviews: tutor['feedbacks'].length,
      country: tutor['country'],
      bio: tutor['bio'],
    )).toList();
    return tutorList;
  }
}
