import 'package:flutter/material.dart';
import 'package:lettutor/presentation/widgets/LettutorAppBar/LetTutorAppBar.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/RecommendedTutors.dart';
import 'package:lettutor/presentation/pages/Home/TutorSearch/TutorSearch.dart';
import 'package:lettutor/presentation/pages/Home/UpcomingLessonNotification.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController scrollController;
  late TutorListProvider tutorListProvider;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    tutorListProvider = context.read<TutorListProvider>();
    tutorListProvider.resetPage();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        tutorListProvider.isFetching == false) {
      tutorListProvider.fetchTutorList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LetTutorAppBar(
        isLoggedIn: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: const Column(
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
