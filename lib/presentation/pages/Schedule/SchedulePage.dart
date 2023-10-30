import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/dummy/lesson.dart';
import 'package:lettutor/presentation/pages/Schedule/DateScheduleCard.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        type: AppBarType.main,
        title: "Schedule",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const PageOverview(),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => DateScheduleCard(
                          lessonList: lessonListGroupedByDate[index],
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

class PageOverview extends StatelessWidget {
  const PageOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 120,
              width: 120,
              child: SvgPicture.asset("assets/images/calendar.svg")),
          Text(
            "Schedule",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 4))),
            child: const Text(
                'Here is a list of the sessions you have booked. You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours.'),
          )
        ],
      ),
    );
  }
}
