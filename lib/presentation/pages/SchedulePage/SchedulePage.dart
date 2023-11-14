import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/presentation/pages/SchedulePage/UpcomingLessonCard.dart';
import 'package:lettutor/presentation/widgets/DateCard/DateCard.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        type: AppBarType.main,
        title: "Schedule",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              PageOverview(
                image: SvgPicture.asset("assets/images/calendar.svg"),
                title: "Schedule",
                overview:
                    "Here is a list of the sessions you have booked. You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours.",
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
                            itemCount: lessonList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                UpcomingLessonCard(lesson: lessonList[index]),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 8,
                            ),
                          ),
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
