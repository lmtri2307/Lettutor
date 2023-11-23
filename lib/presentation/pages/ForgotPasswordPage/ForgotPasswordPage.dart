import 'package:flutter/material.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/presentation/pages/ForgotPasswordPage/ResetPasswordForm.dart';
import 'package:lettutor/presentation/pages/ForgotPasswordPage/ResetPasswordSuccessful.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/service/AuthService.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool _hasSucceed = false;

  Future<void> _resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 5));
    await const AuthService().resetPassword(email).then((value) {
      setState(() {
        _hasSucceed = true;
      });
    }).onError((error, stackTrace) {
      showErrorSnackBar(context, "Email doesn't exist");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PageAppBar(title: "LetTutor", type: AppBarType.sub),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _hasSucceed
                  ? const ResetPasswordSuccessful()
                  : ResetPasswordForm(
                      onResetPassword: _resetPassword,
                    )),
        ));
  }
}