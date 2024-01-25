import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/helpers/pagination.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/pages/HistoryPage/HistoryLessonCard.dart';
import 'package:lettutor/presentation/widgets/DateCard/DateCard.dart';
import 'package:lettutor/presentation/widgets/EmptyListText/EmptyListText.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _lessonService = const LessonService();
  final _pagination = Pagination();

  Widget _build(BuildContext context, int numberPages,
      List<List<Lesson>> lessonListGroupedByDate) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            PageOverview(
              image: SvgPicture.asset("assets/images/history.svg"),
              title: "History",
              overview:
                  "The following is a list of lessons you have attended.\n"
                  "You can review the details of the lessons you have attended",
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
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index2) =>
                                      HistoryLessonCard(
                                          lesson: lessonListGroupedByDate[index]
                                              [index2]),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 8,
                                      ),
                                  itemCount:
                                      lessonListGroupedByDate[index].length),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 24,
                            ),
                        itemCount: lessonListGroupedByDate.length),
                  ),
            numberPages > 0
                ? NumberPaginator(
                    initialPage: _pagination.currentPage - 1,
                    numberPages: numberPages,
                    onPageChange: (int page) {
                      setState(() {
                        _pagination.currentPage = page + 1;
                      });
                    },
                  )
                : const EmptyListText(text: "No lesson found")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        type: AppBarType.main,
        title: "History",
      ),
      body: FutureBuilder(
        future: _lessonService.getHistoryLessonList(
            _pagination.currentPage, _pagination.perPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          _pagination.totalItems = snapshot.data!.$2;
          return _build(
              context,
              _pagination.totalPages,
              const DateHelper()
                  .groupByDate(snapshot.data!.$1, (p0) => p0.startTime));
        },
      ),
    );
  }
}
