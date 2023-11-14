import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/presentation/pages/HistoryPage/HistoryLessonCard.dart';
import 'package:lettutor/presentation/widgets/DateCard/DateCard.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';

import '../../widgets/PageAppBar/PageAppBar.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        type: AppBarType.main,
        title: "History",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageOverview(
                image: SvgPicture.asset("assets/images/history.svg"),
                title: "History",
                overview: "The following is a list of lessons you have attended.\n"
                    "You can review the details of the lessons you have attended",
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DateCard(
                      dateTime: lessonListGroupedByDate[index][0].startTime,
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              HistoryLessonCard(lesson: lessonList[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 8,
                          ),
                          itemCount: lessonList.length),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 24,
                    ),
                    itemCount: lessonListGroupedByDate.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
