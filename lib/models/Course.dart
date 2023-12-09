import 'package:lettutor/models/Level.dart';
import 'package:lettutor/models/Topic.dart';

class Course {
  Course(
      {required this.imageUrl,
      required this.name,
      this.description,
      required this.numberOfTopic,
      this.courseDetail,
      required this.level});

  final String imageUrl;
  final String name;
  final String? description;
  final Level level;
  final int numberOfTopic;
  CourseDetail? courseDetail;
}

class CourseDetail {
  final List<Topic> topicList;
  final String? importance;
  final String? outcome;
  const CourseDetail({required this.topicList, this.importance, this.outcome});
}
