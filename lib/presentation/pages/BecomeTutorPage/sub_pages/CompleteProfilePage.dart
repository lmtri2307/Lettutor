import 'package:flutter/material.dart';

class CompleteProfilePage extends StatelessWidget {
  const CompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme
        .of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Text(title, style: textStyle),
          const Expanded(child: Divider())
        ],
      ),
    );
  }
}

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CV extends StatelessWidget {
  const CV({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class LanguageISpeak extends StatelessWidget {
  const LanguageISpeak({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class WhoITeach extends StatelessWidget {
  const WhoITeach({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
