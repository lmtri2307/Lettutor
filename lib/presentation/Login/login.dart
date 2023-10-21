import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

enum FormFieldType{
  email("email", "abc@example.com"),
  password("password", "");
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
            const Padding(
              padding: EdgeInsets.all(48),
              child: Column(
                children: [
                  Text(
                    "Say hello to your \nEnglish tutors",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 113, 240),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center align text
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      "Become fluent faster through one on one video chat lessons tailored to your goals.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  LoginForm()
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
          SizedBox(height: 20,),
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