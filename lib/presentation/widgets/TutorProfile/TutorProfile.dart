import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/AvatarWidget/AvatarWidget.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/Rating.dart';

class TutorProfile extends StatelessWidget {
  const TutorProfile(
      {super.key,
      required this.tutor,
      this.showFavoriteButton = true,
      this.showNumOfReviews = false,
      this.onTap,
      this.onToggleFavorite});

  final Tutor tutor;
  final bool showFavoriteButton;
  final bool showNumOfReviews;
  final void Function()? onTap;
  final void Function()? onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Expanded(
              child: AvatarWidget(
                name: tutor.name,
                avatarUrl: tutor.avatar,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            // Information
            Expanded(
              flex: 2,
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
                    tutor.country ?? "Unknown country",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Rating(rating: tutor.rating),
                        ...showNumOfReviews &&
                                tutor.numOfReviews != null
                            ? [
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("(${tutor.numOfReviews})",
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
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      icon: tutor.isFavorite
                          ? const Icon(
                              Icons.favorite_rounded,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.favorite_border_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                      onPressed: () {
                        if (onToggleFavorite != null) {
                          onToggleFavorite!();
                        }
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
