import 'package:lettutor/models/Level.dart';
import 'package:lettutor/models/Topic.dart';

class Course {
  Course({required this.imageUrl,
    required this.name,
    this.description,
    required this.topicList,
    this.importance,
    required this.level});

  final String imageUrl;
  final String name;
  final String? description;
  final List<Topic> topicList;
  final Level level;
  final String? importance;
}
