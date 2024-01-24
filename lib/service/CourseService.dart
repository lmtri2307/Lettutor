import 'package:lettutor/dummy/course.dart';
import 'package:lettutor/dummy/topic.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/repository/CourseRepository.dart';

class CourseService {
  const CourseService();
  final _courseRepository = const CourseRepository();

  Future<(List<Course>, int)> getCourseList(int page, int perPage) async {
    return await _courseRepository.fetchCourses(page, perPage);
  }

  Future<CourseDetail> getCourseDetail(Course course) async {
    return await _courseRepository.getCourseDetail(course);
  }
}
