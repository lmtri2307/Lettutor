import 'package:flutter/material.dart';
import 'package:lettutor/presentation/AppBar/AppBar.dart';
import 'package:lettutor/presentation/Home/TutorSearch.dart';
import 'package:lettutor/presentation/Home/UpcomingLesson.dart';

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
              child: TutorSearch(),
            )
          ],
        ),
      ),
    );
  }
}
