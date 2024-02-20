import 'dart:collection';
import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorRepository {
  const TutorRepository();

  final baseUrl = '/tutor';

  Future<List<Tutor>> searchTutorList(
      TutorSearchFormData searchForm, int page, int limit) async {
    // build search request body
    final Map<dynamic, dynamic> body = {
      'page': page.toString(),
      'perPage': limit.toString(),
    };
    if (searchForm.name != null) {
      body['search'] = searchForm.name;
    }
    if (searchForm.specialty != null) {
      final specialty = SpecialtyMapper.map(searchForm.specialty!);
      if (specialty.isNotEmpty) {
        body['filters'] = (body['filters'] ?? {}) as Map<dynamic, dynamic>;
        body['filters'] = {
          'specialties': [specialty],
        };
      }
    }

    if (searchForm.tutorNationality != null) {
      body['filters'] = (body['filters'] ?? {}) as Map<dynamic, dynamic>;
      if (searchForm.tutorNationality!.name == "Native") {
        body['filters'] = {
          ...body['filters'],
          'nationality': {'isNative': true}
        };
      }
      if (searchForm.tutorNationality!.name == "Vietnamese") {
        body['filters'] = {
          ...body['filters'],
          'nationality': {'isVietNamese': true}
        };
      }
      if (searchForm.tutorNationality!.name == "Foreign") {
        body['filters'] = {
          ...body['filters'],
          'nationality': {'isNative': false, 'isVietNamese': false}
        };
      }
    }

    // fetch api
    final response = await apiClient.post(Uri.parse('$baseUrl/search'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
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

  Future<TutorDetail> getTutorDetail(Tutor tutor) async {
    // fetch api
    final response = await apiClient.get(Uri.parse('$baseUrl/${tutor.id}'));
    final data = json.decode(response.body);
    // convert to model
    final tutorDetail = TutorDetail(
      videoUrl: data['video'],
      languages: data['languages'],
      interest: data['interests'],
      experience: data['experience'],
      education: data['education'],
      numOfReviews: data['totalFeedback'],
    );
    return tutorDetail;
  }

  Future<void> reportTutor(Tutor tutor, String content) async {
    final Map<String, dynamic> body = {
      'content': content,
      'tutorId': tutor.id,
    };

    // fetch api
    final response = await apiClient.post(Uri.parse('$baseUrl/report'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    final data = json.decode(response.body);
    return;
  }

  Future<void> toggleFavoriteTutor(Tutor tutor) async {
    final Map<String, dynamic> body = {
      'tutorId': tutor.id,
    };

    // fetch api
    final response = await apiClient.post(
        Uri.parse('/user/manageFavoriteTutor'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body));
    final data = json.decode(response.body);
    return;
  }

  Future<List<Review>> getReviewsOfTutor(Tutor tutor) async {
    // fetch api
    final response = await apiClient.get(Uri.parse('/feedback/v2/${tutor.id}'));
    final data = json.decode(response.body);
    // convert to model
    final reviewList = data['data']["rows"]
        .map<Review>((review) => Review(
              author: User(
                id: review['firstId'],
                email: "",
                name: review['firstInfo']['name'],
                avatar: review['firstInfo']['avatar'],
              ),
              rating: review['rating'] is int
                  ? review['rating'].toDouble()
                  : review['rating'],
              comment: review['content'],
              createdAt: DateTime.parse(review['updatedAt']),
            ))
        .toList();
    return reviewList;
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
