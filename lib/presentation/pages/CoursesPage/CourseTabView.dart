import 'package:flutter/material.dart';
import 'package:lettutor/helpers/pagination.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/presentation/pages/CoursesPage/PreviewCard.dart';
import 'package:lettutor/service/CourseService.dart';
import 'package:number_paginator/number_paginator.dart';

class CourseTabView extends StatefulWidget {
  const CourseTabView({super.key});

  @override
  State<CourseTabView> createState() => _CourseTabViewState();
}

class _CourseTabViewState extends State<CourseTabView> {
  final _courseService = const CourseService();
  final _pagination = Pagination();

  Widget _buildOnHasData(
      BuildContext context, int numberPages, List<Course> courseList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: courseList
                .map((course) => PreviewCard(
                      onTap: () {
                        Navigator.pushNamed(context, "/course",
                            arguments: course);
                      },
                      imageUrl: course.imageUrl,
                      title: course.name,
                      description: course.description,
                      additionalDetail:
                          '${course.level.name} • ${course.numberOfTopic} lessons',
                    ))
                .toList(),
          ),
        ),
        NumberPaginator(
          initialPage: _pagination.currentPage - 1,
          numberPages: numberPages,
          onPageChange: (int page) {
            setState(() {
              _pagination.currentPage = page + 1;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _courseService.getCourseList(
          _pagination.currentPage, _pagination.perPage),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        _pagination.totalItems = snapshot.data!.$2;
        return _buildOnHasData(
            context, _pagination.totalPages, snapshot.data!.$1);
      },
    );
  }
}
