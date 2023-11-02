import 'package:flutter/material.dart';
import 'package:lettutor/enums/language.dart';

class LanguageOption extends StatelessWidget {
  const LanguageOption({super.key, required this.language});

  final Language language;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        language.imageWidget,
        const SizedBox(width: 8),
        Expanded(child: Text(language.name)),
      ],
    );
  }
}