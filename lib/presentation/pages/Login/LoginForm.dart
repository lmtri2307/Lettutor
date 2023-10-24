import 'package:flutter/material.dart';
import 'package:lettutor/enums/form_field_type.dart';

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