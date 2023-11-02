import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Level.dart';

class Course {
  Course(
      {required this.imageUrl,
      required this.name,
      this.description,
      required this.lessonList,
      required this.level});

  final String imageUrl;
  final String name;
  final String? description;
  final List<Lesson> lessonList;
  final Level level;
}
