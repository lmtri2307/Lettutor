import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/helpers/pagination.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/pages/SchedulePage/UpcomingLessonCard.dart';
import 'package:lettutor/presentation/widgets/DateCard/DateCard.dart';
import 'package:lettutor/presentation/widgets/EmptyListText/EmptyListText.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/PageOverview/PageOverview.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _lessonService = const LessonService();
  final _pagination = Pagination();

  void _onCancelLesson(Lesson lesson) {
    _lessonService
        .cancelLesson(lesson)
        .then((value) => setState(() {
              _pagination.totalItems -= 1;
              // check if need to go to previous page
              if (_pagination.totalItems % _pagination.perPage == 0 &&
                  _pagination.currentPage > _pagination.totalPages) {
                _pagination.currentPage -= 1;
              }
            }))
        .catchError((error) {
      showErrorSnackBar(context, error.toString().substring(11));
    });
  }

  Widget _buildOnHasData(BuildContext context, int numberPages,
      List<List<BookedLesson>> lessonListGroupedByDate) {
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
              title: AppLocalizations.of(context).schedule,
              overview:
                  AppLocalizations.of(context).scheduleOverview
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
                        AppLocalizations.of(context).noSchedule,
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
                                itemCount:
                                    lessonListGroupedByDate[index].length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index2) =>
                                    UpcomingLessonCard(
                                        onCanceled: _onCancelLesson,
                                        lesson: lessonListGroupedByDate[index]
                                            [index2]),
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
                : EmptyListText(text: AppLocalizations.of(context).noSchedule),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        type: AppBarType.main,
        title: AppLocalizations.of(context).schedule,
      ),
      body: FutureBuilder(
        future: _lessonService.getScheduleLessonList(
            _pagination.currentPage, _pagination.perPage),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          _pagination.totalItems = snapshot.data!.$2;
          return _buildOnHasData(
              context,
              _pagination.totalPages,
              const DateHelper()
                  .groupByDate(snapshot.data!.$1, (p0) => p0.startTime));
        },
      ),
    );
  }
}
