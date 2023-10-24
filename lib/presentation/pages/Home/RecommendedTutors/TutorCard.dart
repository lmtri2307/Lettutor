import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/Home/RecommendedTutors/Rating.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';
class TutorCard extends StatelessWidget {
  const TutorCard({super.key, required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Avatar
                  tutor.avatar,
                  const SizedBox(
                    width: 18,
                  ),
                  // Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold),
                        ),
                        Rating(rating: tutor.rating)
                      ],
                    ),
                  ),
                  // Favorite Button
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
            ),
            const SizedBox(
              height: 10,
            ),
            MultipleLabelsPicker(
                labelList: tutor.labels.map((e) => e.name).toList(),
                defaultStyle: StateStyle(
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    textColor: Theme.of(context).primaryColor),
                selectedStyle: StateStyle(
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    textColor: Theme.of(context).primaryColor),
                onSelected: (e) {}),
            const SizedBox(
              height: 8,
            ),
            Text(tutor.introduction),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                icon: Icon(
                  Icons.edit_calendar,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  'Book',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}