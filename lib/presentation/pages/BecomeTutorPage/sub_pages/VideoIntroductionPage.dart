import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/NoteContainer.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/SectionDivider.dart';
import 'package:video_player/video_player.dart';

class VideoIntroductionPage extends StatefulWidget {
  const VideoIntroductionPage({super.key});

  @override
  State<VideoIntroductionPage> createState() => _VideoIntroductionPageState();
}

class _VideoIntroductionPageState extends State<VideoIntroductionPage> {
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _onChooseVideo() async {
    final videoPicker = ImagePicker();
    final videoPicked =
        await videoPicker.pickVideo(source: ImageSource.gallery);
    if (kIsWeb) {
      final bytes = await videoPicked?.readAsBytes();
      if (bytes != null) {
        _videoController?.dispose();
        final blob = html.Blob([bytes]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
        await _videoController?.initialize();
        setState(() {});
      }
    } else {
      if (videoPicked != null) {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(File(videoPicked.path))
          ..initialize().then((value) {
            setState(() {});
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const _Overview(),
        const SizedBox(
          height: 14,
        ),
        const SectionDivider(
          title: "Introduction video",
        ),
        NoteContainer(
          noteList: [
            TextSpan(
                text: "A few helpful tips:\n"
                    "   1. Find a clean and quiet space\n"
                    "   2. Smile and look at the camera\n"
                    "   3. Dress smart\n"
                    "   4. Speak for 1-3 minutes\n"
                    "   5. Brand yourself and have fun!\n",
                style: theme.textTheme.bodySmall),
            TextSpan(
                text:
                    "Note: We only support uploading video file that is less than 64 MB in size.",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                ))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: theme.primaryColor),
          onPressed: () {
            _onChooseVideo();
          },
          child: const Text("Choose video"),
        ),
        const SizedBox(
          height: 10,
        ),

        //Video controller
        if (_videoController != null)
          // VisibilityDetector(
          //   key: const Key("VideoPlayerKey"),
          //   onVisibilityChanged: (info) {
          //     if (info.visibleFraction == 0 && mounted) {
          //       videoPlayerController?.pause();
          //     } else {
          //       videoPlayerController?.play();
          //     }
          //   },
          //   child: InkWell(
          //     onTap: () {
          //       setState(() {
          //         videoPlayerController!.value.isPlaying
          //             ? videoPlayerController?.pause()
          //             : videoPlayerController?.play();
          //       });
          //     },
          //     child:
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: Stack(
              children: [
                Chewie(
                  controller: ChewieController(
                    videoPlayerController: _videoController!,
                  ),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: videoPlayerController!.value.isPlaying
                //       ? const SizedBox()
                //       : const Icon(Icons.pause),
                // ),
              ],
            ),
          ),
        //   ),
        // ),
        // )
      ],
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset("assets/images/video.svg", height: 120),
        Text(
          "Introduce yourself",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.",
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
