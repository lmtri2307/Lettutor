import 'package:lettutor/models/Level.dart';

class Book {
  const Book(
      {required this.level,
      required this.description,
      required this.imageUrl,
      required this.name});

  final String imageUrl;
  final String name;
  final String? description;
  final Level level;
}
