import 'package:lettutor/models/Category.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/Level.dart';
import 'package:lettutor/repository/CourseRepository.dart';


class CourseSearchForm {
  List<Level> levels = [];
  List<Category> categories = [];
  bool? isAscending;
  String? searchText;
}

class CourseService {
  const CourseService();

  final _courseRepository = const CourseRepository();

  Future<(List<Course>, int)> getCourseList(int page, int perPage, CourseSearchForm form) async {
    return await _courseRepository.fetchCourses(page, perPage, form);
  }

  Future<CourseDetail> getCourseDetail(Course course) async {
    return await _courseRepository.getCourseDetail(course);
  }

  Future<List<Category>> getAllCategories() async {
    return await _courseRepository.getAllCategories();
  }
}
