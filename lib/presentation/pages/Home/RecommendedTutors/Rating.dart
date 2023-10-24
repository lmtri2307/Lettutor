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
      children: List.generate(
          5,
          (index) => index < rating!
              ? rating! - index < 1
                  ? Icon(
                      Icons.star_half_outlined,
                      color: Colors.yellow.shade700,
                      size: 20,
                    )
                  : Icon(
                      Icons.star_outlined,
                      color: Colors.yellow.shade700,
                      size: 20,
                    )
              : Icon(
                  Icons.star_border_outlined,
                  color: Colors.yellow.shade700,
                  size: 20,
                )),
    );
  }
}
