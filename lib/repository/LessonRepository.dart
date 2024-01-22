import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';

class LessonRepository {
  const LessonRepository();

  final baseUrl = '/schedule';

  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor, int page) async {
    final url = '$baseUrl?tutorId=${tutor.id}&page=$page';
    final response = await apiClient.get(Uri.parse(url));
    final data = json.decode(response.body);

    final lessonList = data['scheduleOfTutor']
        .map<Lesson>((lesson) => Lesson(
              id: lesson['scheduleDetails'][0]['id'],
              tutor: tutor,
              startTime:
                  DateTime.fromMillisecondsSinceEpoch(lesson['startTimestamp']),
              duration:
                  DateTime.fromMillisecondsSinceEpoch(lesson['startTimestamp'])
                      .difference(DateTime.fromMillisecondsSinceEpoch(
                          lesson['endTimestamp']))
                      .abs(),
              isAvailable: !lesson['isBooked'],
            ))
        .toList();
    return lessonList;
  }

  Future<void> bookLesson(Lesson lesson, String note) async {
    final body = {
      'scheduleDetailIds': [lesson.id],
      'note': note,
    };
    final response = await apiClient.post(Uri.parse('/booking'),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    final data = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(data['message']);
    }
  }
}
