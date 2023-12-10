import 'package:flutter/material.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/smile.png",
            width: 100,
            fit: BoxFit.contain,
            color: theme.primaryColor,
          ),
          Text(
            "You have done all the steps\nPlease, wait for the operator's approval",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 24,
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: theme.primaryColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Back to home"),
          )
        ],
      ),
    );
  }
}
