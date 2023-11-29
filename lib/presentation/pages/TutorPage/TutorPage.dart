import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorDetails.dart';
import 'package:lettutor/presentation/widgets/AssetVideo/AssetVideo.dart';
import 'package:lettutor/presentation/widgets/IconTextButton/IconTextButton.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/TutorProfile.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key, required this.tutor});

  final Tutor tutor;

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  late Tutor _tutor;
  late final TutorListProvider _tutorListProvider;

  @override
  void initState() {
    super.initState();
    _tutor = widget.tutor;
    _tutorListProvider = context.read<TutorListProvider>();
  }


  final TutorService tutorService = const TutorService();

  void _onFavorite() async {
     final newTutor = await tutorService.toggleFavoriteTutor(_tutor);
     _tutorListProvider.toggleFavoriteTutor(_tutor);

     setState(() {
       _tutor = newTutor;
     });
  }

  Widget _uiBuild(BuildContext context) {
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
                tutor: _tutor,
                showFavoriteButton: false,
                showNumOfReviews: true,
                height: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _tutor.bio ?? "",
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
                      color: _tutor.isFavorite? Colors.red : null,
                      iconData: _tutor.isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      label: 'Favorite',
                      onPressed: _onFavorite),
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
              if (_tutor.detail?.videoUrl != null)
                Center(
                  child: AssetVideo(
                    url: _tutor.detail!.videoUrl!,
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              TutorDetails(tutor: _tutor),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tutorService.getTutorDetail(_tutor),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _uiBuild(context);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
