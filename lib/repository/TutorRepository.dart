import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorRepository {
  const TutorRepository();

  final baseUrl = '/tutor';

  // Future<List<Tutor>> getTutorList(int page, int limit) async {
  //   // fetch api
  //
  //   final response = await apiClient
  //       .get(Uri.parse('$baseUrl/more?perPage=$limit&page=$page'));
  //   final data = json.decode(response.body);
  //   // convert to model
  //   final tutorList = data['tutors']['rows']
  //       .map<Tutor>((tutor) => Tutor(
  //             id: tutor['userId'],
  //             name: tutor['name'],
  //             avatar: tutor['avatar'],
  //             rating: tutor['rating'],
  //             isFavorite: data['favoriteTutor'].any((favoriteTutor) =>
  //                 favoriteTutor['secondId'] == tutor['userId']),
  //             specialties: tutor['specialties'],
  //             // tutor['feedbacks'] is a list of feedbacks
  //             numOfReviews: tutor['feedbacks'].length,
  //             country: tutor['country'],
  //             bio: tutor['bio'],
  //           ))
  //       .toList();
  //   return tutorList;
  // }

  Future<List<Tutor>> searchTutorList(
      TutorSearchFormData searchForm, int page, int limit) async {
    // build search request body
    final Map<String, dynamic> body = {
      'page': page.toString(),
      'perPage': limit.toString(),
    };
    if (searchForm.name != null) {
      body['search'] = searchForm.name;
    }
    if (searchForm.specialty != null) {
      final specialty = SpecialtyMapper.map(searchForm.specialty!);
      if (specialty.isNotEmpty) {
        body['filters'] = {
          'specialties': [specialty],
        };
      }
    }

    // fetch api
    final response =
        await apiClient.post(Uri.parse('$baseUrl/search'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(body));
    final data = json.decode(response.body);
    // convert to model
    final tutorList = data["rows"]
        .map<Tutor>((tutor) => Tutor(
              id: tutor['userId'],
              name: tutor['name'],
              avatar: tutor['avatar'],
              rating: tutor['rating'],
              isFavorite: tutor['isFavoriteTutor'] ?? false,
              specialtyList: tutor['specialties']
                  .split(',')
                  .map<Specialty>((e) => SpecialtyMapper.reverseMap(e))
                  .toList(),
              country: tutor['country'],
              bio: tutor['bio'],
            ))
        .toList();
    return tutorList;
  }
}

class SpecialtyMapper {
  static Map<String, String> dict = {
    "English for Business": "business-english",
    "English for kids": "english-for-kids",
    "Conversational": "conversational-english",
    "IELTS": "ielts",
    "STARTERS": "starters",
    "MOVERS": "movers",
    "FLYERS": "flyers",
    "KET": "ket",
    "PET": "pet",
    "TOEFL": "toefl",
    "TOEIC": "toeic",
  };

  static String map(Specialty specialty) {
    return dict[specialty.name] ?? "";
  }

  static Specialty reverseMap(String specialty) {
    return Specialty(dict.keys
        .firstWhere((key) => dict[key] == specialty, orElse: () => ""));
  }
}
