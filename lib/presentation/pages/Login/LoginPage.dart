import 'package:flutter/material.dart';
import 'package:lettutor/helpers/show_toast.dart';
import 'package:lettutor/presentation/widgets/LetTutorAppBar/LetTutorAppBar.dart';
import 'package:lettutor/presentation/widgets/AuthenticationForm/AuthenticationForm.dart';
import 'package:lettutor/presentation/pages/Login/SocialIcons.dart';
import 'package:lettutor/providers/AuthProvider.dart';
import 'package:lettutor/service/AuthService.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isAuthenticating = false;

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  void _onLoginFail(String message){
    showErrorSnackBar(context, 'Log in failed! $message');
  }

  void _login(
      {required AuthProvider authRepository,
      required String email,
      required String password}) async {
    setState(() {
      _isAuthenticating = true;
    });

    try{
      final user = await const AuthService()
          .loginWithEmailAndPassword(email, password);
      authRepository.setUser(user);
    }catch(err){
      _onLoginFail(err.toString().substring(11));
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/password");
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer<AuthProvider>(
                    builder: (BuildContext context, AuthProvider value,
                        Widget? child) {
                      return TextButton(
                          onPressed: () {
                            _login(
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
                            "Login",
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
                        "Not a member yet?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");
                          },
                          child: Text(
                            "Sign up",
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
