import 'dart:math';

import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/dummy/level.dart';
import 'package:lettutor/models/Course.dart';

final courseList = List.generate(
    5,
    (index) => Course(
        imageUrl: "assets/images/preview_course.png",
        name: "Life in the Internet Age",
        description: "Let's discuss how technology is changing the way we live",
        lessonList: lessonList.sublist(0, Random().nextInt(lessonList.length)),
        level: levelList[Random().nextInt(levelList.length)])).toList();
