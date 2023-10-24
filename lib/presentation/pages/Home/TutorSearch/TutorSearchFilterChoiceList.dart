import 'package:flutter/material.dart';
import 'package:lettutor/enums/tutor_filter_choice.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';

class TutorSearchFilterChoiceList extends StatelessWidget {
  const TutorSearchFilterChoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    TutorFilterChoice chosen = TutorFilterChoice.all;
    return MultipleLabelsPicker(
        onSelected: (isSelected) {},
        labelList: TutorFilterChoice.values.map((e) => e.name).toList(),
        defaultStyle: StateStyle(
            backgroundColor: const Color.fromARGB(255, 228, 230, 235),
            textColor: const Color.fromARGB(255, 100, 100, 100)),
        selectedStyle: StateStyle(
            backgroundColor: const Color.fromARGB(255, 221, 234, 255),
            textColor: Theme.of(context).primaryColor));
  }
}
