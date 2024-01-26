import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:provider/provider.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, required this.lesson});

  final BookedLesson lesson;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  Timer? _timer;
  final lessonService = const LessonService();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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

  Future<void> _joinMeeting() async {
    Navigator.of(context).pop();
    await lessonService.joinLessonMeeting(
        context.read<AuthProvider>().user!, widget.lesson);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.lesson.startTime.isBefore(DateTime.now())) {
        await _joinMeeting();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Center(
          child: Text(
            'Lesson is starting in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white60),
          ),
        ),
        Center(
          child: Text(
            _getTimeUntilLesson(widget.lesson),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.red),
          ),
        ),
        const SizedBox(height: 60),
        TextButton(
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                backgroundColor: Colors.white),
            onPressed: () async {
              await _joinMeeting();
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
                        ?.copyWith(color: Theme.of(context).primaryColor)),
              ],
            )),
      ]),
    );
  }
}
