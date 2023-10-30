import 'package:flutter/material.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/presentation/pages/Schedule/LessonCard.dart';

class DateScheduleCard extends StatelessWidget {
  const DateScheduleCard({super.key, required this.lessonList});

  final List<Lesson> lessonList;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 241, 241, 241),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              DateFormat('EEE, dd MMM yy').format(lessonList[0].startTime),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 24,
            ),
            ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    LessonCard(lesson: lessonList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 8,
                    ),
                itemCount: lessonList.length),
          ],
        ),
      ),
    );
  }
}
