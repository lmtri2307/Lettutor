import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';


class CourseTabView extends StatelessWidget {
  const CourseTabView({super.key, required this.courseList});

  final List<Course> courseList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: courseList
          .map((course) => PreviewCard(
                imageUrl: course.imageUrl,
                title: course.name,
                description: course.description,
                additionalDetail:
                    '${course.level.name} • ${course.topicList.length} lessons',
              ))
          .toList(),
    );
  }
}
