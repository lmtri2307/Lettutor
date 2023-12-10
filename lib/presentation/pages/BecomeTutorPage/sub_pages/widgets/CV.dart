import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/NoteContainer.dart';

class CV extends StatelessWidget {
  const CV({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "Students will view this information on your profile to decide if you're a good fit for them.",
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 14,
        ),
        NoteContainer(
          noteList: [
            TextSpan(
              text:
                  "In order to protect your privacy, please do not share your personal information (email, phone number, social email, skype, etc) in your profile.",
              style: theme.textTheme.bodySmall,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Interests",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 1,
          maxLines: 5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your interests";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Education",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 1,
          maxLines: 5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your education";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Experience",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 1,
          maxLines: 5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your experience";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(
          height: 24,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Current or Previous Profession",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 1,
          maxLines: 5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your profession";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
