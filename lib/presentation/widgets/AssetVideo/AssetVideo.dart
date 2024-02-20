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
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 300),
      child: FutureBuilder(
          future: videoPlayerController!.initialize(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(chewieController != null) {
              chewieController!.dispose();
            }
            chewieController = ChewieController(
              errorBuilder: (context, errorMessage) {
                return Center(
                    child: Text("Video not available",
                        style: theme.textTheme.headlineLarge?.copyWith(
                            color: Colors.red.shade300,
                            fontWeight: FontWeight.bold)));
              },
              videoPlayerController: videoPlayerController!,
              autoInitialize: true,
              aspectRatio: videoPlayerController!.value.aspectRatio,
            );
            return Chewie(
              controller: chewieController!,
            );
          }),
    );
  }
}
