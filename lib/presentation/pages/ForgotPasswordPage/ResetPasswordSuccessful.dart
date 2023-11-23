import 'package:flutter/material.dart';

class ResetPasswordSuccessful extends StatelessWidget {
  const ResetPasswordSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    theme = theme.copyWith(
        textTheme: theme.textTheme.copyWith(
            headlineLarge:
            theme.textTheme.headlineLarge?.copyWith(color: Colors.black)));

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Reset Password", style: theme.textTheme.headlineLarge),
          const SizedBox(height: 15),
          Text(
            "Check your inbox for a link to reset your password.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ]);
  }
}