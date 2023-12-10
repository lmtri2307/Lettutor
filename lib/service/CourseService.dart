import 'package:lettutor/dummy/course.dart';
import 'package:lettutor/dummy/topic.dart';
import 'package:lettutor/models/Course.dart';

class CourseService {
  const CourseService();

  Future<List<Course>> getCourseList() async {
    await Future.delayed(const Duration(seconds: 2));
    return courseList;
  }

  Future<CourseDetail> getCourseDetail(Course course) async {
    await Future.delayed(const Duration(seconds: 2));
    return CourseDetail(
      topicList: topicList.sublist(0, course.numberOfTopic),
      importance:
          "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
      outcome:
          "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
    );
  }
}