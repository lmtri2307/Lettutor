import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/pages/SchedulePage/UpcomingLessonCard.dart';
import 'package:lettutor/presentation/widgets/DateCard/DateCard.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  final _lessonService = const LessonService();

  Widget _buildOnHasData(
      BuildContext context, List<List<Lesson>> lessonListGroupedByDate) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
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
            lessonListGroupedByDate.isEmpty
                ? Center(
                    child: Column(children: [
                      Image.asset(
                        "assets/images/empty_lesson_list.png",
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        "There is no lesson schedule yet!",
                        style: theme.textTheme.bodySmall,
                      )
                    ]),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => DateCard(
                              dateTime:
                                  lessonListGroupedByDate[index][0].startTime,
                              child: ListView.separated(
                                itemCount: lessonListGroupedByDate[index].length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index2) =>
                                    UpcomingLessonCard(
                                        lesson: lessonListGroupedByDate[index][index2]),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;
    return Scaffold(
      appBar: const PageAppBar(
        type: AppBarType.main,
        title: "Schedule",
      ),
      body: FutureBuilder(
        future: _lessonService.getBookedLessonList(user!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return _buildOnHasData(
              context,
              const DateHelper()
                  .groupByDate(snapshot.data!, (p0) => p0.startTime));
        },
      ),
    );
  }
}
