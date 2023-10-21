import 'package:flutter/material.dart';
import 'package:lettutor/presentation/AppBar/AppBar.dart';
import 'package:lettutor/presentation/Home/UpcomingLesson.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(isLogined: true,),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              UpcomingLesson(),
            ],
        ),
      ),
    );
  }
}
