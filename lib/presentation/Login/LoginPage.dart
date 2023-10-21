import 'package:flutter/material.dart';
import 'package:lettutor/presentation/AppBar/AppBar.dart';
import 'package:lettutor/presentation/Login/LoginForm.dart';
import 'package:lettutor/presentation/Login/SocialIcons.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
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
                  const LoginForm(),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: null,
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
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: null,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: const Size.fromHeight(56),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
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
                          onPressed: null,
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
