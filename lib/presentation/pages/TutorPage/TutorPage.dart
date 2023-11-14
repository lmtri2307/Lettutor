import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorDetails.dart';
import 'package:lettutor/presentation/widgets/AssetVideo/AssetVideo.dart';
import 'package:lettutor/presentation/widgets/IconTextButton/IconTextButton.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/TutorProfile.dart';

class TutorPage extends StatelessWidget {
  const TutorPage({super.key, required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: "Teacher Details",
        type: AppBarType.sub,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TutorProfile(
                tutor: tutor,
                showFavoriteButton: false,
                showNumberOfReviews: true,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                tutor.introduction,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconTextButton(
                      iconData: Icons.favorite_border_rounded,
                      label: 'Favorite',
                      onPressed: () {}),
                  IconTextButton(
                      iconData: Icons.reviews_outlined,
                      label: 'Review',
                      onPressed: () {}),
                  IconTextButton(
                      iconData: Icons.report_outlined,
                      label: 'Report',
                      onPressed: () {}),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              if(tutor.videoUrl != null)
                Center(
                  child: AssetVideo(
                    url: tutor.videoUrl!,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              TutorDetails(tutor: tutor)
            ],
          )),
    );
  }
}
