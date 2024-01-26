import 'package:flutter/material.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/widgets/LessonOverview/LessonOverview.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class UpcomingLessonCard extends StatelessWidget {
  const UpcomingLessonCard(
      {super.key, required this.lesson, required this.onCanceled});

  final lessonService = const LessonService();
  final BookedLesson lesson;
  final Function(BookedLesson lesson) onCanceled;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                height: 84,
                child: LessonOverview(
                  lesson: lesson,
                )),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.grey.shade300))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder()),
                    onPressed: () async {
                      await lessonService.joinLessonMeeting(
                          context.read<AuthProvider>().user!, lesson);
                    },
                    child: Text(
                      'Go to meeting',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        foregroundColor: Colors.red),
                    onPressed: () {
                      onCanceled(lesson);
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Cancel',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
