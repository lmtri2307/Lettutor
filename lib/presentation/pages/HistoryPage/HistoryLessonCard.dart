import 'package:flutter/material.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/presentation/widgets/LessonOverview/LessonOverview.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryLessonCard extends StatelessWidget {
  const HistoryLessonCard({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                height: 84,
                child: LessonOverview(
                  lesson: lesson,
                )),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: Colors.grey.shade300)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context).noRequestForLesson,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 1, color: Colors.grey.shade300)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(AppLocalizations.of(context).tutorNotReview,
                style: TextStyle(color: Colors.grey.shade700)),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: Colors.grey.shade300))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder()),
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context).addARating,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        foregroundColor: Colors.red),
                    onPressed: () {},
                    child: Text(
                      textAlign: TextAlign.center,
                      AppLocalizations.of(context).report,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
