import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';

class TutorDetails extends StatelessWidget {
  const TutorDetails({super.key, required this.tutor});

  final Tutor tutor;

  Widget _tutorDetailItem(BuildContext context,
      {required String title, Widget? widget}) {
    return Column(
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
            child: widget),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _tutorDetailItem(
          context,
          title: "Education",
          widget: Text(
            tutor.detail?.education ?? "",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey.shade700),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _tutorDetailItem(
          context,
          title: "Language",
          widget: tutor.detail != null
              ? IgnorePointer(
                  child: MultipleLabelsPicker(
                    itemList: tutor.detail!.languageList,
                    getLabelFromItem: (item) => item,
                    onItemSelected: (e) {},
                    defaultStyle: StateStyle(
                        textColor: Theme.of(context).primaryColor,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 234, 255)),
                    selectedStyle: StateStyle(
                        textColor: Theme.of(context).primaryColor,
                        backgroundColor:
                            const Color.fromARGB(255, 221, 234, 255)),
                  ),
                )
              : null,
        ),
        _tutorDetailItem(context,
            title: "Specialties",
            widget: IgnorePointer(
              child: MultipleLabelsPicker(
                itemList: tutor.specialtyList,
                getLabelFromItem: (item) => item.name,
                onItemSelected: (e) {},
                defaultStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
                selectedStyle: StateStyle(
                    textColor: Theme.of(context).primaryColor,
                    backgroundColor: const Color.fromARGB(255, 221, 234, 255)),
              ),
            )),
        _tutorDetailItem(
          context,
            title: "Interests",
            widget: Text(
              tutor.detail?.interest ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade700),
            )),
        _tutorDetailItem(
          context,
            title: "Teaching experience",
            widget: Text(
              tutor.detail?.experience ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade700),
            ))
      ],
    );
  }
}
