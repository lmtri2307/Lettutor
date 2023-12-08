import 'dart:math';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/dummy/user.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Review.dart';

DateTime generateRandomFutureDate() {
  final random = Random();
  final now = DateTime.now();
  final randomDaysInFuture = random.nextInt(5); // for next 5 dáy
  return now.add(Duration(days: randomDaysInFuture));
}

List<DateTime> generateSortedRandomListOfFutureDate() {
  var result = List.generate(5, (index) => generateRandomFutureDate());
  result.sort(
    (a, b) => a.compareTo(b),
  );
  return result;
}

List<List<Lesson>> groupByDate(List<Lesson> lessonList) {
  List<List<Lesson>> result = [];
  List<Lesson> currentGroup = [];

  for (var i = 0; i < lessonList.length; i++) {
    if (currentGroup.isEmpty ||
        lessonList[i].startTime.day == currentGroup[0].startTime.day &&
            lessonList[i].startTime.month == currentGroup[0].startTime.month &&
            lessonList[i].startTime.year == currentGroup[0].startTime.year) {
      currentGroup.add(lessonList[i]);
    } else {
      result.add(currentGroup);
      currentGroup = [lessonList[i]];
    }
  }
  result.add(currentGroup);

  return result;
}

final lessonList = generateSortedRandomListOfFutureDate()
    .map((timeInFuture) => Lesson(
        tutor: tutorList[Random().nextInt(tutorList.length)],
        startTime: timeInFuture,
        duration: const Duration(minutes: 30),
        isAvailable: Random().nextInt(2) == 1,
        review: Review(
            author: userList[0],
            comment: "Sample Comment",
            rating: Random().nextInt(10) / 2,
            createdAt: DateTime.parse('2023-12-07 09:30:00'))))
    .toList();
final bookedLessonList = <Lesson>[];

final lessonListGroupedByDate = groupByDate(lessonList);
