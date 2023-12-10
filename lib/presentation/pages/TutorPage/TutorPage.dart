import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorDetails.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorReportDialog.dart';
import 'package:lettutor/presentation/pages/TutorPage/TutorReviewsDialog.dart';
import 'package:lettutor/presentation/widgets/AssetVideo/AssetVideo.dart';
import 'package:lettutor/presentation/widgets/IconTextButton/IconTextButton.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/TutorProfile.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class TutorPage extends StatelessWidget {
  const TutorPage({super.key, required this.tutor});

  final Tutor tutor;
  final TutorService _tutorService = const TutorService();

  void _onFavorite(TutorListProvider tutorListProvider) async {
    tutorListProvider.toggleFavoriteTutor(tutor);
  }

  Widget _build(BuildContext context, AsyncSnapshot<TutorDetail?> snapshot) {
    final theme = Theme.of(context);
    if (snapshot.hasData) {
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
                  showNumOfReviews: true,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  tutor.bio ?? "",
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
                    Consumer<TutorListProvider>(
                      builder: (context, value, child) => IconTextButton(
                        color: tutor.isFavorite ? Colors.red : null,
                        iconData: tutor.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        label: 'Favorite',
                        onPressed: () => _onFavorite(value),
                      ),
                    ),
                    IconTextButton(
                        iconData: Icons.reviews_outlined,
                        label: 'Review',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                TutorReviewsDialog(tutor: tutor),
                          );
                        }),
                    IconTextButton(
                        iconData: Icons.report_outlined,
                        label: 'Report',
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return TutorReportDialog(tutor: tutor);
                            },
                          ).then((value) {
                            if (value) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                          size: theme.textTheme.headlineMedium
                                              ?.fontSize,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Report Success',
                                          style: theme.textTheme.headlineMedium
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK')),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (tutor.detail?.videoUrl != null)
                  Center(
                    child: AssetVideo(
                      url: tutor.detail!.videoUrl!,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                TutorDetails(tutor: tutor),
                Center(
                  // alignment: Alignment.center,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(0),
                        padding: const EdgeInsets.all(16),
                        side:
                            BorderSide(color: theme.primaryColor, width: 1.5)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/tutor-schedule",
                          arguments: tutor);
                    },
                    child: const Text(
                      'Book This Tutor',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                )
              ],
            )),
      );
    }
    return const Scaffold(
        appBar: PageAppBar(
          title: "Teacher Details",
          type: AppBarType.sub,
        ),
        body: Center(child: CircularProgressIndicator()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _tutorService.getTutorDetail(tutor), builder: _build);
  }
}
