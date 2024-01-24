import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Level.dart';
import 'package:lettutor/models/Topic.dart';

class CourseRepository {
  const CourseRepository();
  final baseurl = "/course";

  Future<(List<Course>, int)> fetchCourses(int page, int perPage) async {
    final response = await apiClient.get(Uri.parse('$baseurl?page=$page&size=$perPage'));
    final data = json.decode(response.body);

    final int count = data['data']['count'];
    final List<Course> courseList = data['data']['rows'].map<Course>((course) {
      return Course(
        id: course['id'],
        name: course['name'],
        description: course['description'],
        imageUrl: course['imageUrl'],
        level: LevelMapper.fromString(course['level']),
        numberOfTopic: course['topics'].length,
      );
    }).toList();
    return (courseList, count);
  }

  Future<CourseDetail> getCourseDetail(Course course) async {
    final response = await apiClient.get(Uri.parse('$baseurl/${course.id}'));
    final data = json.decode(response.body);
    final List<Topic> topicList = data['data']['topics'].map<Topic>((topic) {
      return Topic(
        id: topic['id'],
        name: topic['name'],
        fileUrl: topic['nameFile'],
      );
    }).toList();
    return CourseDetail(
      topicList: topicList,
      importance: data['data']['reason'],
      outcome: data['data']['purpose'],
    );
  }
}

class LevelMapper {
  static final courseLevels = {
    '0': const Level(name: 'Any level'),
    '1': const Level(name: 'Beginner') ,
    '2': const Level(name: 'High Beginner'),
    '3': const Level(name: 'Pre-Intermediate'),
    '4': const Level(name: 'Intermediate'),
    '5': const Level(name: 'Upper-Intermediate'),
    '6': const Level(name: 'Advanced'),
    '7': const Level(name: 'Proficiency')
  };

  static Level fromString(String level) {
    return courseLevels[level]!;
  }
}