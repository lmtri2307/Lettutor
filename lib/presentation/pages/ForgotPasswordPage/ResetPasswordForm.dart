import 'package:flutter/material.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.onResetPassword});

  final Future<void> Function(String email) onResetPassword;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool _isResetting = false;
  final TextEditingController emailEditingController = TextEditingController();

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
          "Please enter your email address to search for your account.",
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email",
            style: theme.textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: emailEditingController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 228, 228, 228), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        ),
        const SizedBox(height: 26),
        TextButton(
          onPressed: () {
            setState(() {
              _isResetting = true;
            });
            widget.onResetPassword(emailEditingController.text).then((value) {
              setState(() {
                _isResetting = false;
              });
            });
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            backgroundColor: theme.primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              height: 16,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isResetting)
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  Text(
                    "Send reset link",
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}