import 'dart:convert';

import 'package:lettutor/configs/httpClient.dart';
import 'package:lettutor/models/Book.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Level.dart';
import 'package:lettutor/models/Topic.dart';
import 'package:lettutor/models/Category.dart';
import 'package:lettutor/service/CourseService.dart';

class CourseRepository {
  const CourseRepository();

  final baseurl = "/course";

  Future<(List<Course>, int)> fetchCourses(
      int page, int perPage, CourseSearchForm form) async {
    // build url
    String url = '$baseurl?page=$page&size=$perPage';
    if (form.levels.isNotEmpty) {
      url += form.levels
          .map((level) => '&level[]=${LevelMapper.toLevelString(level)}')
          .join();
    }
    if (form.categories.isNotEmpty) {
      url += form.categories
          .map((category) => '&categoryId[]=${category.id}')
          .join();
    }
    if (form.isAscending != null) {
      url += '&order[]=level';
      if (form.isAscending!) {
        url += '&orderBy[]=ASC';
      } else {
        url += '&orderBy[]=DESC';
      }
    }
    if (form.searchText != null) {
      url += '&q=${form.searchText}';
    }

    final response = await apiClient.get(Uri.parse(url));
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

  Future<(List<Book>, int)> getBookList(int page, int perPage) async {
    final response =
        await apiClient.get(Uri.parse('/e-book?page=$page&size=$perPage'));
    final data = json.decode(response.body);
    final int count = data['data']['count'];
    final List<Book> bookList = data['data']['rows'].map<Book>((book) {
      return Book(
        name: book['name'],
        description: book['description'],
        imageUrl: book['imageUrl'],
        level: LevelMapper.fromString(book['level']),
      );
    }).toList();
    return (bookList, count);
  }

  Future<List<Category>> getAllCategories() async {
    final response = await apiClient.get(Uri.parse('/content-category'));
    final data = json.decode(response.body);
    final List<Category> categoryList = data['rows'].map<Category>((category) {
      return Category(
        id: category['id'],
        name: category['title'],
      );
    }).toList();
    return categoryList;
  }
}

class LevelMapper {
  static final courseLevels = {
    '0': const Level(name: 'Any level'),
    '1': const Level(name: 'Beginner'),
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

  static String toLevelString(Level level) {
    return courseLevels.keys.firstWhere((key) => courseLevels[key] == level);
  }

  static List<Level> getAllLevels() {
    return courseLevels.values.toList();
  }
}
