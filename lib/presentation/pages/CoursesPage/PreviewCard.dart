import 'package:flutter/material.dart';

class PreviewCard extends StatelessWidget {
  const PreviewCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      this.description,
      this.additionalDetail});

  final String imageUrl;
  final String title;
  final String? description;
  final String? additionalDetail;

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
          Image.asset(
            imageUrl,
            height: 200,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 24, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  description ?? "",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  additionalDetail ?? "",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
