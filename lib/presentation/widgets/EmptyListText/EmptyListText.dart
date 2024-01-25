import 'package:flutter/material.dart';

class EmptyListText extends StatelessWidget {
  const EmptyListText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(text,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ))));
  }
}
