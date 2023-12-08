import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/providers/LessonProvider.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:provider/provider.dart';

class UpcomingLessonNotification extends StatelessWidget {
  const UpcomingLessonNotification({super.key});

  final _lessonService = const LessonService();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthProvider>().user;
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Consumer<LessonProvider>(
                builder: (context, value, child) {
                  if (value.needFetchUpcomingLesson) {
                    return FutureBuilder(
                      future: value.fetchUpcomingLesson(user!),
                      builder: (context, snapshot) => const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return _Notification(lesson: value.upcomingLesson);
                },
              ),
              const SizedBox(
                height: 12,
              ),
              FutureBuilder(
                future: _lessonService.getTotalLessonTime(user!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
                  }

                  return _TotalLearnedTime(learnedTime: snapshot.data!);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Notification extends StatefulWidget {
  const _Notification({super.key, this.lesson});

  final Lesson? lesson;

  @override
  State<_Notification> createState() => _NotificationState();
}

class _NotificationState extends State<_Notification> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  String _getLessonTime(Lesson lesson) {
    final startTime = DateFormat.jm().format(lesson.startTime);
    final endTime =
        DateFormat.jm().format(lesson.startTime.add(lesson.duration));
    final weekday = DateFormat('EEE').format(lesson.startTime);
    final date = DateFormat('d MMM yy').format(lesson.startTime);

    return '$weekday, $date $startTime - $endTime';
  }

  String _getTimeUntilLesson(Lesson lesson) {
    final now = DateTime.now();
    final difference = lesson.startTime.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);
    return '${days > 0 ? '${days}d ' : ''}${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return widget.lesson == null
        ? Text(
            'You have no upcoming lesson',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Upcoming Lesson',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                _getLessonTime(widget.lesson!),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "(starts in ${_getTimeUntilLesson(widget.lesson!)})",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.yellow),
              ),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, "/call");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.youtube,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Text('Enter Lesson Room',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor)),
                    ],
                  )),
            ],
          );
  }
}

class _TotalLearnedTime extends StatelessWidget {
  const _TotalLearnedTime({super.key, required this.learnedTime});

  final Duration learnedTime;

  String _getLabel(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);

    return 'Total lesson time is  ${hours.toString().padLeft(2, '0')} ${hours > 1 ? "hours" : "hour"} ${minutes.toString().padLeft(2, '0')} ${minutes > 1 ? "minutes" : "minute"}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _getLabel(learnedTime),
      style:
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
    );
  }
}
