import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({super.key, this.rating});

  final double? rating;

  @override
  Widget build(BuildContext context) {
    if (rating == null) {
      return Text(
        "No review yet",
        style:
            TextStyle(fontStyle: FontStyle.italic, color: Colors.grey.shade500),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
          5,
          (index) => FittedBox(
            child: Icon(
                  index < rating!
                      ? rating! - index < 1
                          ? Icons.star_half_outlined
                          : Icons.star_outlined
                      : Icons.star_border_outlined,
                  color: Colors.yellow.shade700,
                ),
          )

      ),
    );
  }
}
