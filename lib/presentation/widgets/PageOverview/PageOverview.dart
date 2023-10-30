import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageOverview extends StatelessWidget {
  const PageOverview(
      {super.key,
      required this.image,
      required this.title,
      required this.overview});

  final Widget image;
  final String title;
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: image,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Colors.grey.withOpacity(0.5), width: 4))),
            child: Text(
              overview,
              style: TextStyle(color: Colors.grey.shade500),
            ),
          )
        ],
      ),
    );
  }
}
