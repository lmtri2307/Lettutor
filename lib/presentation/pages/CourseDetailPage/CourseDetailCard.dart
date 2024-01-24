import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';

class CourseDetailCard extends StatelessWidget {
  const CourseDetailCard({super.key, required this.course});
  final Course course;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            width: 1, color: Color.fromARGB(255, 216, 216, 216)),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 16),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            course.imageUrl,
            // height: 260,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  course.description ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 20))
                      ),
                      onPressed: () {},
                      child: const Text("Discover",
                          style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
