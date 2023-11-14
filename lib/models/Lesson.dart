import 'package:lettutor/models/Review.dart';

import 'Tutor.dart';

class Lesson {
  Lesson(this.tutor, this.startTime, this.duration, {this.review});

  final Tutor tutor;
  final DateTime startTime;
  final Duration duration;
  final Review? review;

  DateTime get endTime => startTime.add(duration);
}
