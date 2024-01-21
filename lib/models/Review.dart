import 'package:lettutor/models/User.dart';

class Review {
  Review(
      {required this.author,
      this.comment,
      required this.rating,
      required this.createdAt});
  final User author;
  final String? comment;
  final double rating;
  final DateTime createdAt;
}
