import 'package:flutter/material.dart';
import 'package:lettutor/presentation/widgets/AppBar/AppBar.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/RecommendedTutors.dart';
import 'package:lettutor/presentation/pages/Home/TutorSearch/TutorSearch.dart';
import 'package:lettutor/presentation/pages/Home/UpcomingLesson.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        isLogined: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UpcomingLesson(),
            Padding(
              padding:
                  EdgeInsets.only(top: 33, left: 30, right: 30, bottom: 49),
              child: Column(
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
