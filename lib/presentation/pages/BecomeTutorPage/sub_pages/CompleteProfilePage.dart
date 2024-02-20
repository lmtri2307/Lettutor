import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/BasicInfo.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/CV.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/LanguageISpeak.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/SectionDivider.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/WhoITeach.dart';

class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Theme(
      data: theme.copyWith(
          inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(color: Colors.grey.shade300),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12)),
      )),
      child: const Column(
        children: [
          Overview(),
          SectionDivider(title: "Basic Info"),
          BasicInfo(),
          SectionDivider(title: "CV"),
          CV(),
          SectionDivider(title: "Language I speak"),
          LanguageISpeak(),
          SectionDivider(title: "Who I teach"),
          WhoITeach(),
        ],
      ),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const CircleAvatar(
            backgroundImage: AssetImage("assets/images/tutor_profile.png"),
            radius: 50),
        const SizedBox(
          width: 12,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up your tutor profile",
              style: theme.textTheme.headlineSmall,
            ),
            Text(
              "Your tutor profile is your chance to market yourself to students on Tutoring. You can make edits later on your profile settings page.\n"
              "New students may browse tutor profiles to find a tutor that fits their learning goals and personality. Returning students may use the tutor profiles to find tutors they've had great experiences with already.",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ))
      ],
    );
  }
}


