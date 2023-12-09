import 'dart:math';

import 'package:lettutor/dummy/level.dart';
import 'package:lettutor/dummy/topic.dart';
import 'package:lettutor/models/Course.dart';

final courseList = List.generate(
    5,
    (index) => Course(
        imageUrl: "assets/images/preview_course.png",
        name: "Life in the Internet Age",
        description: "Let's discuss how technology is changing the way we live",
        numberOfTopic: Random().nextInt(topicList.length - 1) + 1,
        // topicList: topicList.sublist(0, Random().nextInt(topicList.length)),
        level: levelList[Random().nextInt(levelList.length)])).toList();
