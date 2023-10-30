import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';

class TutorDetails extends StatelessWidget {
  const TutorDetails({super.key, required this.tutor});

  final Tutor tutor;

  @override
  Widget build(BuildContext context) {
    tutorDetailItem(String title, Widget detail) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: detail),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        tutorDetailItem(
          "Education",
          Text(
            "BA",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        tutorDetailItem(
            "Language",
            IgnorePointer(
              child: MultipleLabelsPicker(
                labelList: tutor.languageList!.map((e) => e.name).toList(),
                onSelected: (e) {},
                defaultStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
                selectedStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
              ),
            )),
        tutorDetailItem(
            "Specialties",
            IgnorePointer(
              child: MultipleLabelsPicker(
                labelList: tutor.specialtyList!.map((e) => e.name).toList(),
                onSelected: (e) {},
                defaultStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
                selectedStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
              ),
            )),
        tutorDetailItem(
            "Interests",
            Text(
              tutor.interest ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade700),
            )),
        tutorDetailItem(
            "Teaching experience",
            Text(
              tutor.experience ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade700),
            ))
      ],
    );
  }
}
