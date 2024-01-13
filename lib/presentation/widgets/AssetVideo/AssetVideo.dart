import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class AssetVideo extends StatefulWidget {
  const AssetVideo({super.key, required this.url});

  final String url;

  @override
  State<AssetVideo> createState() => _AssetVideoState();
}

class _AssetVideoState extends State<AssetVideo> {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    final theme = Theme.of(context);
    chewieController = ChewieController(
      errorBuilder: (context, errorMessage) {
        return Center(
            child: Text("Video not available",
                style: theme.textTheme.headlineLarge?.copyWith(
                    color: Colors.red.shade300,
                    fontWeight: FontWeight.bold)));
      },
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: Chewie(
        controller: chewieController,
      ),
    );
  }
}
