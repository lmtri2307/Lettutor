import 'dart:math';

import 'package:lettutor/dummy/level.dart';
import 'package:lettutor/dummy/topic.dart';
import 'package:lettutor/models/Course.dart';

final courseList = List.generate(
    5,
    (index) => Course(
        imageUrl: "assets/images/preview_course.png",
        name: "Life in the Internet Age",
        importance: "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
        description: "Let's discuss how technology is changing the way we live",
        topicList: topicList.sublist(0, Random().nextInt(topicList.length)),
        level: levelList[Random().nextInt(levelList.length)])).toList();
