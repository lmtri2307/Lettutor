import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';
import 'package:lettutor/service/CourseService.dart';

class CourseTabView extends StatelessWidget {
  const CourseTabView({super.key});

  final _courseService = const CourseService();

  Widget _buildOnHasData(BuildContext context, List<Course> courseList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: courseList
          .map((course) => PreviewCard(
                onTap: () {
                  Navigator.pushNamed(context, "/course", arguments: course);
                },
                imageUrl: course.imageUrl,
                title: course.name,
                description: course.description,
                additionalDetail:
                    '${course.level.name} • ${course.numberOfTopic} lessons',
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _courseService.getCourseList(1, 10),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return _buildOnHasData(context, snapshot.data!.$1);
      },
    );
  }
}
