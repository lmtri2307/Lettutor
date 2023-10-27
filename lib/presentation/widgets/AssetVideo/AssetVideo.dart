import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class AssetVideo extends StatelessWidget {
  const AssetVideo({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    // controller.play();
    final videoPlayerController = VideoPlayerController.asset(url);
    videoPlayerController.initialize();

    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
    );

    return FittedBox(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300),
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}