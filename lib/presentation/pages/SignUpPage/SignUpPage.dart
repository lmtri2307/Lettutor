import 'package:flutter/material.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/helpers/validator.dart';
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
  final retypedPasswordEditingController = TextEditingController();
  late final Validator validator;

  @override
  void initState() {
    super.initState();
    validator = Validator(context);
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    retypedPasswordEditingController.dispose();
    super.dispose();
  }

  void _onError(String message) {
    showErrorSnackBar(context, 'Sign up failed! $message.');
  }

  void _onSuccess() {
    Navigator.pushNamed(context, "/login");
    showSuccessSnackBar(context, 'Sign up successful! Please log in.');
  }

  bool _validate(
      {required String email,
      required String password,
      required String retypedPassword}) {
    final emailError = validator.validateEmail(email);
    if (emailError != null) {
      showErrorSnackBar(context, emailError);
      return false;
    }
    final passwordError = validator.validatePassword(password);
    if (passwordError != null) {
      showErrorSnackBar(context, passwordError);
      return false;
    }
    final retypedPasswordError =
        validator.validateRetypedPassword(retypedPassword, password);
    if (retypedPasswordError != null) {
      showErrorSnackBar(context, retypedPasswordError);
      return false;
    }
    return true;
  }

  Future<void> _signup(
      {required AuthProvider authRepository,
      required String email,
      required String password,
      required String retypedPassword}) async {
    if (!_validate(
        email: email, password: password, retypedPassword: retypedPassword)) {
      return;
    }
    setState(() {
      _isAuthenticating = true;
    });
    try {
      await const AuthService().signupWithEmailAndPassword(email, password);
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
                    retypedPasswordEditingController:
                        retypedPasswordEditingController,
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
                                password: passwordEditingController.text,
                                retypedPassword:
                                    retypedPasswordEditingController.text);
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
