import 'package:flutter/material.dart';
import 'package:lettutor/dummy/tutor.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/TutorCard.dart';

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
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: tutorList
              .map((e) => Column(
                    children: [
                      TutorCard(
                        tutor: e,
                      ),
                      const SizedBox(height: 8)
                    ],
                  ))
              .toList(),
        )
      ],
    );
  }
}




