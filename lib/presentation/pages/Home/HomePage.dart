import 'package:flutter/material.dart';
import 'package:lettutor/presentation/widgets/LettutorAppBar/LetTutorAppBar.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/RecommendedTutors.dart';
import 'package:lettutor/presentation/pages/Home/TutorSearch/TutorSearch.dart';
import 'package:lettutor/presentation/pages/Home/UpcomingLessonNotification.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final _tutorService = const TutorService();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final tutorListProvider = context.read<TutorListProvider>();
      tutorListProvider.setTutorListFuture(_tutorService.getTutorList());
    });

    return const Scaffold(
      appBar: LetTutorAppBar(
        isLoggedIn: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UpcomingLessonNotification(),
            Padding(
              padding:
                  EdgeInsets.only(top: 33, left: 30, right: 30, bottom: 49),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TutorSearch(),
                  Divider(
                    color: Color.fromARGB(255, 228, 230, 235),
                    height: 48,
                    thickness: 1,
                  ),
                  RecommendedTutors(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
