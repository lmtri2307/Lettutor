import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';
import 'package:lettutor/presentation/widgets/TutorProfile/TutorProfile.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:provider/provider.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({super.key, required this.tutor});

  final Tutor tutor;

  void _onToggleFavorite(TutorListProvider tutorListProvider) async {
    tutorListProvider.toggleFavoriteTutor(tutor);
  }

  @override
  Widget build(BuildContext context) {
    final tutorListProvider = context.read<TutorListProvider>();
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TutorProfile(
              onTap: () {
                Navigator.pushNamed(context, "/tutor", arguments: tutor);
              },
              tutor: tutor,
              onToggleFavorite: () => _onToggleFavorite(tutorListProvider),
            ),
            const SizedBox(
              height: 10,
            ),
            MultipleLabelsPicker(
                itemList: tutor.specialtyList,
                getLabelFromItem: (specialty) => specialty.name,
                defaultStyle: StateStyle(
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    textColor: Theme.of(context).primaryColor),
                selectedStyle: StateStyle(
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                    textColor: Theme.of(context).primaryColor),
                onItemSelected: (e) {}),
            const SizedBox(
              height: 8,
            ),
            Text(
              tutor.bio ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade500),
            ),
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
                onPressed: () {
                  Navigator.pushNamed(context, "/tutor-schedule",
                      arguments: tutor);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
