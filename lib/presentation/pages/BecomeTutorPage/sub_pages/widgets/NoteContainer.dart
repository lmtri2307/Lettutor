import 'package:flutter/material.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({super.key, required this.noteList, });

  final List<TextSpan> noteList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColorLight),
          color: theme.primaryColorLight.withAlpha(96)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: RichText(
        text: TextSpan(children: noteList),
      ),
    );
  }
}
