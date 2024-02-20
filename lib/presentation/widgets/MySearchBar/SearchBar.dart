import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CoursesPage.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key, this.hintText});

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final courseFormProvider = context.read<CourseFormProvider>();
    return TextField(
      onSubmitted: (value) {
        print("submit");
        courseFormProvider.setSearchText(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(right: 24),
        hintStyle: TextStyle(color: Colors.grey[400]),
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
