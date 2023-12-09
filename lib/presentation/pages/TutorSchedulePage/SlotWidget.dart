import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/pages/TutorSchedulePage/BookingDialog.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/providers/LessonProvider.dart';
import 'package:provider/provider.dart';

class SlotWidget extends StatelessWidget {
  const SlotWidget({super.key, required this.lesson});

  final Lesson lesson;

  void _onBook(BuildContext context, LessonProvider lessonProvider,
      AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => BookingDialog(
        lesson: lesson,
        onBook: () async {
          await lessonProvider.bookLesson(lesson, authProvider.user!);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lessonProvider = context.read<LessonProvider>();
    final authProvider = context.read<AuthProvider>();
    return FilledButton(
      style: FilledButton.styleFrom(
          // shape: const RoundedRectangleBorder(),
          alignment: Alignment.centerLeft,
          // surfaceTintColor: isAvailable ? theme.primaryColor : Colors.grey,
          backgroundColor:
              lesson.isAvailable ? theme.primaryColor : Colors.grey),
      onPressed: lesson.isAvailable
          ? () => _onBook(context, lessonProvider, authProvider)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              lesson.isAvailable ? "Available" : "Reserved",
              style: TextStyle(
                color: lesson.isAvailable ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ),
          Text(
            "${DateFormat("HH:mm").format(lesson.startTime)} - ${DateFormat("HH:mm").format(lesson.endTime)}",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color:
                    lesson.isAvailable ? Colors.white : Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}
