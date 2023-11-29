import 'package:lettutor/models/Review.dart';

import 'OldTutor.dart';

class Lesson {
  Lesson(this.tutor, this.startTime, this.duration, {this.review});

  final OldTutor tutor;
  final DateTime startTime;
  final Duration duration;
  final Review? review;

  DateTime get endTime => startTime.add(duration);
}
