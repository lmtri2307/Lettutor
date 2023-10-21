import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Language {
  vietnam("vietnam"),
  us("united-states");

  final String name;

  const Language(this.name);

  Widget get imageWidget => SvgPicture.asset(
        'images/$name.svg',
        semanticsLabel: 'Your SVG Image',
        width: 24,
        height: 24,
        fit: BoxFit.cover,
      );
}

enum FormFieldType {
  email("email", "abc@example.com"),
  password("password", "******");

  const FormFieldType(this.name, this.placeholder);

  final String name;
  final String placeholder;

  String get label => name.toUpperCase();
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'images/logo.svg',
          semanticsLabel: 'Your SVG Image',
          fit: BoxFit.contain,
          width: 180,
        ),
        actions: [
          // PopupMenuButton(itemBuilder: itemBuilder)
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(225, 228, 230, 235),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PopupMenuButton<Language>(
                icon: SvgPicture.asset(
                  'images/vietnam.svg',
                  semanticsLabel: 'Your SVG Image',
                  width: 16,
                  height: 16,
                  fit: BoxFit.cover,
                ),
                onSelected: (Language result) {
                  // Handle your menu selection here
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<Language>>[
                  const PopupMenuItem<Language>(
                    value: Language.vietnam,
                    child: LanguageOption(language: Language.vietnam),
                  ),
                  const PopupMenuItem<Language>(
                    value: Language.us,
                    child: LanguageOption(language: Language.us),
                  ),
                ],
                offset: const Offset(0, 40),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset("images/login.png"),
            Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormField(field: FormFieldType.email),
          SizedBox(
            height: 20,
          ),
          CustomFormField(field: FormFieldType.password)
        ],
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField({super.key, required this.field});

  final FormFieldType field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: field.placeholder,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 228, 228, 228), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }
}

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.facebookF, color: Color(0xFF1877F2)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.google, color: Color(0xFFDB4437)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2.0, // border width
            ),
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.mobileAlt, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
