import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/Rating.dart';

class TutorProfile extends StatelessWidget {
  const TutorProfile(
      {super.key,
      required this.tutor,
      this.showFavoriteButton = true,
      this.showNumberOfReviews = false,
      this.height});

  final Tutor tutor;
  final bool showNumberOfReviews;
  final bool showFavoriteButton;
  final double? height;
  final double minHeight = 92;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null
          ? height! < minHeight
              ? minHeight
              : height
          : minHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Avatar
          tutor.avatar,
          const SizedBox(
            width: 18,
          ),
          // Information
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tutor.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  tutor.country,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Rating(rating: tutor.rating),
                      ...showNumberOfReviews
                          ? [
                              const SizedBox(
                                width: 8,
                              ),
                              Text("(${tutor.reviewList?.length.toString()})",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.grey.shade500,
                                        fontStyle: FontStyle.italic,
                                      ))
                            ]
                          : [],
                    ],
                  ),
                )
              ],
            ),
          ),
          // Favorite Button
          if (showFavoriteButton)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }
}
