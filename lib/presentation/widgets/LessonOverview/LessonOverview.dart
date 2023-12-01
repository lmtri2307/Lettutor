import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/Lesson.dart';

class LessonOverview extends StatelessWidget {
  const LessonOverview({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FittedBox(
            child: SizedBox.square(
                child: CircleAvatar(
                    child: lesson.tutor.avatar != null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(lesson.tutor.avatar!),
                              ),
                            ),
                          )
                        : FittedBox(child: Avatar(name: lesson.tutor.name))))),
        const SizedBox(
          width: 18,
        ),
        // Information
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.tutor.name ?? "Unknown name",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                lesson.tutor.country ?? "Unknown country",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              ),
              Text(
                "${DateFormat("HH:mm").format(lesson.startTime)} - ${DateFormat("HH:mm").format(lesson.endTime)}",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
