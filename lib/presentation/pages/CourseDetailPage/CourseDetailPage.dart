import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/presentation/pages/CourseDetailPage/CourseDetailCard.dart';
import 'package:lettutor/presentation/pages/CourseDetailPage/TopicCard.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    theme = theme.copyWith(
      textTheme: theme.textTheme.copyWith(
          headlineMedium:
              theme.textTheme.headlineMedium?.copyWith(color: Colors.black),
          bodyMedium:
              theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          bodySmall:
              theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w100)),
    );

    return Scaffold(
      appBar: const PageAppBar(
        title: "Course Detail",
        type: AppBarType.sub,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top:40 ,bottom: 56, left: 26, right: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CourseDetailCard(
              course: course,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Overview',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.help_outline, color: Colors.red),
                const SizedBox(width: 6),
                Text(
                  'Why Take This Course',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, bottom: 14),
              child: Text(
                course.importance ?? "",
                style: theme.textTheme.bodySmall,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.help_outline, color: Colors.red),
                const SizedBox(width: 6),
                Text(
                  'What will you be able to do',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, bottom: 14),
              child: Text(
                course.importance ?? "",
                style: theme.textTheme.bodySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Experience Level',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            Row(
              children: [
                Icon(Icons.group_add_outlined, color: theme.primaryColor),
                const SizedBox(width: 6),
                Text(
                  course.level.name,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Course Length',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            Row(
              children: [
                Icon(Icons.book_outlined, color: theme.primaryColor),
                const SizedBox(width: 6),
                Text(
                  '${course.topicList.length} topics',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            ...List.generate(
                course.topicList.length,
                (index) =>
                    TopicCard(topic: course.topicList[index], index: index))
          ],
        ),
      ),
    );
  }
}
