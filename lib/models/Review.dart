import 'package:lettutor/models/User.dart';

class Review {
  Review({required this.author, required this.comment, required this.rating});

  final User author;
  final String comment;
  final double rating;
}
