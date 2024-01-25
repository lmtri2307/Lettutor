import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/TutorCard.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:provider/provider.dart';

class RecommendedTutors extends StatelessWidget {
  const RecommendedTutors({super.key});

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
        Consumer<TutorListProvider>(
            builder: (context, tutorListProvider, child) => Column(children: [
                  if (tutorListProvider.isEndOfList &&
                      tutorListProvider.tutorList.isEmpty)
                    Center(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("No tutors found",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic,
                                    )))),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return TutorCard(
                          tutor: tutorListProvider.tutorList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: tutorListProvider.tutorList.length,
                  ),
                  if (!tutorListProvider.isEndOfList)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ]))
      ],
    );
  }
}
