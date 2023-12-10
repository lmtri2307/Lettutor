import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Text(title, style: textStyle),
          const Expanded(child: Divider())
        ],
      ),
    );
  }
}
