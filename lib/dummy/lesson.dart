import 'dart:math';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/dummy/user.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Review.dart';

DateTime generateRandomFutureDate() {
  final random = Random();
  final now = DateTime.now();
  final randomDaysInFuture = random.nextInt(5); // for next 5 dáy
  final randomHoursInFuture = random.nextInt(6); // for next 6 hours
  return now
      .add(Duration(days: randomDaysInFuture, hours: randomHoursInFuture));
}

DateTime generateRandomPastDate() {
  final random = Random();
  final now = DateTime.now();
  final randomDaysInFuture = random.nextInt(5); // for next 5 dáy
  final randomHoursInFuture = random.nextInt(6); // for next 6 hours
  return now
      .subtract(Duration(days: randomDaysInFuture, hours: randomHoursInFuture));
}

List<DateTime> generateSortedRandomListOfFutureDate() {
  var result = List.generate(5, (index) => generateRandomFutureDate());
  result.sort(
    (a, b) => a.compareTo(b),
  );
  return result;
}

final lessonList = generateSortedRandomListOfFutureDate()
    .map((timeInFuture) => Lesson(
          id: "randomId",
          tutor: tutorList[0],
          startTime: timeInFuture,
          duration: const Duration(minutes: 30),
          isAvailable: Random().nextInt(2) == 1,
        ))
    .toList();

final bookedLessonList = List.generate(
    5,
    (index) => Lesson(
        id: "randomId",
        tutor: tutorList[0],
        startTime: generateRandomPastDate(),
        duration: const Duration(minutes: 30)));
