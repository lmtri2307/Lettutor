import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Tutor.dart';

class Lesson {
  const Lesson(
      {required this.tutor,
      required this.startTime,
      required this.duration,
      this.review,
      this.isAvailable = true});

  final Tutor tutor;
  final DateTime startTime;
  final Duration duration;
  final Review? review;
  final bool isAvailable;

  DateTime get endTime => startTime.add(duration);
}
