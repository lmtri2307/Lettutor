import 'dart:math';

import 'package:lettutor/dummy/level.dart';
import 'package:lettutor/models/Book.dart';

final bookList = List.generate(
    5,
    (index) => Book(
        level: levelList[Random().nextInt(levelList.length)],
        description:
            "For teenagers who have an excellent vocabulary background and brilliant communication skills.",
        imageUrl:
            "assets/images/preview_book.jpeg",
        name: "What a world 1")).toList();
