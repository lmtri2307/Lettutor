import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Tutor.dart';

class Lesson {
  Lesson(
      {required this.tutor,
      required this.startTime,
      required this.duration,
      required this.id,
      this.isAvailable = true});

  final Tutor tutor;
  final DateTime startTime;
  final Duration duration;
  final String id;
  bool isAvailable;

  DateTime get endTime => startTime.add(duration);

  Lesson copyWith({
    String? id,
    Tutor? tutor,
    DateTime? startTime,
    Duration? duration,
    Review? review,
    bool? isAvailable,
  }) {
    return Lesson(
        tutor: tutor ?? this.tutor,
        id: id ?? this.id,
        startTime: startTime ?? this.startTime,
        duration: duration ?? this.duration,
        isAvailable: isAvailable ?? this.isAvailable);
  }
}

class BookedLesson extends Lesson {
  BookedLesson({
    required Tutor tutor,
    required DateTime startTime,
    required Duration duration,
    required String id,
    required this.studentMeetingLink,
  }) : super(tutor: tutor, startTime: startTime, duration: duration, id: id);

  final String studentMeetingLink;

  String get token => studentMeetingLink.split("=")[1];
}
