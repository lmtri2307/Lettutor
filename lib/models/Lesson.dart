import 'Tutor.dart';

class Lesson {
  Lesson(this.tutor, this.startTime, this.duration);

  final Tutor tutor;
  final DateTime startTime;
  final Duration duration;

  DateTime get endTime => startTime.add(duration);
}
