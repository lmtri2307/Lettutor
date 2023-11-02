import 'package:flutter/material.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Lesson is starting in\n00:59:59',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white60),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
                child: Icon(
              Icons.mic_rounded,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.video_call,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.comment,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.mobile_screen_share,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.front_hand,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.fullscreen_outlined,
              color: Colors.white60,
            )),
            Expanded(
                child: Icon(
              Icons.phone,
              color: Colors.red,
            )),
          ],
        ),
      ),
    );
  }
}
