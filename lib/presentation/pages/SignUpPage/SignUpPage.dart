import 'package:flutter/material.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/presentation/pages/Login/SocialIcons.dart';
import 'package:lettutor/presentation/widgets/AuthenticationForm/AuthenticationForm.dart';
import 'package:lettutor/presentation/widgets/LetTutorAppBar/LetTutorAppBar.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isAuthenticating = false;

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  void _onError(String message){
    showErrorSnackBar(context, 'Sign up failed! $message.');
  }

  void _onSuccess(){
    Navigator.pushNamed(context, "/login");
    showSuccessSnackBar(context, 'Sign up successful! Please log in.');
  }

  Future<void> _signup(
      {required AuthProvider authRepository,
      required String email,
      required String password}) async {
    setState(() {
      _isAuthenticating = true;
    });
    try{
      await const AuthService()
          .signupWithEmailAndPassword(email, password);
      _onSuccess();
    } catch (e) {
      _onError(e.toString().substring(11));
    }
    setState(() {
      _isAuthenticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LetTutorAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset("assets/images/login.png"),
            Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Say hello to your \nEnglish tutors",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center, // Center align text
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Become fluent faster through one on one video chat lessons tailored to your goals.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AuthenticationForm(
                    emailEditingController: emailEditingController,
                    passwordEditingController: passwordEditingController,
                  ),
                  const SizedBox(height: 20),
                  Consumer<AuthProvider>(
                    builder: (BuildContext context, AuthProvider value,
                        Widget? child) {
                      return TextButton(
                          onPressed: () {
                            _signup(
                                authRepository: value,
                                email: emailEditingController.text,
                                password: passwordEditingController.text);
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            minimumSize: const Size.fromHeight(56),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: child!);
                    },
                    child: _isAuthenticating
                        ? const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            "Signup",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Text(
                      "Or continue with",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SocialIcons(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: Text(
                            "Log in",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
