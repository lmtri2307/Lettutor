import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Tutor.dart';

class Lesson {
  Lesson({required this.tutor,
    required this.startTime,
    required this.duration,
    this.review,
    this.isAvailable = true});

  final Tutor tutor;
  final DateTime startTime;
  final Duration duration;
  final Review? review;
  bool isAvailable;

  DateTime get endTime => startTime.add(duration);

  Lesson copyWith({
    Tutor? tutor,
    DateTime? startTime,
    Duration? duration,
    Review? review,
    bool? isAvailable,
  }) {
    return Lesson(tutor: tutor ?? this.tutor,
        startTime: startTime ?? this.startTime,
        duration: duration ?? this.duration,
        review: review ?? this.review,
        isAvailable: isAvailable ?? this.isAvailable);
  }
}
