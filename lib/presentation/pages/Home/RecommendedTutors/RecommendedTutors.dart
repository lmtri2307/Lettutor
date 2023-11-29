import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/TutorCard.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class RecommendedTutors extends StatelessWidget {
  const RecommendedTutors({super.key});

  final tutorService = const TutorService();

  Future<List<Tutor>> _fetchData() async {
    final tutorList = await tutorService.getTutorList();
    tutorList.sort(
      (a, b) {
        if (a.isFavorite && !b.isFavorite) {
          return -1;
        } else if (!a.isFavorite && b.isFavorite) {
          return 1;
        } else if (a.rating == null || b.rating == null) {
          return a.rating == null && b.rating == null
              ? 0
              : a.rating == null
                  ? 1
                  : -1;
        } else {
          return b.rating!.compareTo(a.rating!);
        }
      },
    );
    return tutorList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recommended Tutors",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        FutureBuilder(
            future:
                Future.delayed(const Duration(seconds: 3), () => _fetchData()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ));
              }
              return Consumer<TutorListProvider>(
                builder: (context, value, child) {
                  if(value.tutorList != snapshot.data!) {
                    print("update from fetched data");
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      value.setTutorList(snapshot.data!);
                    });
                  }
                  print("listener rebuild");
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {

                      return TutorCard(tutor: value.tutorList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: value.tutorList.length,
                  );
                },
              );
            })
      ],
    );
  }
}
