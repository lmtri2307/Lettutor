import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm(
      {super.key,
      required this.emailEditingController,
      required this.passwordEditingController,
      this.retypedPasswordEditingController});

  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController? retypedPasswordEditingController;

  @override
  State<AuthenticationForm> createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  @override
  void dispose() {
    widget.emailEditingController.dispose();
    widget.passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormField(
            label: "EMAIL",
            placeholder: "abc@example.com",
            controller: widget.emailEditingController,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomFormField(
            label: "PASSWORD",
            placeholder: "******",
            obscureText: true,
            controller: widget.passwordEditingController,
          ),
          if (widget.retypedPasswordEditingController != null)
            ...[
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                label: "RETYPE PASSWORD",
                placeholder: "******",
                obscureText: true,
                controller: widget.retypedPasswordEditingController,
              )
            ]
        ],
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.label,
      required this.placeholder,
      this.obscureText = false,
      this.controller});

  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey[400]),
            hintText: placeholder,
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
