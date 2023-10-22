import 'package:flutter/material.dart';
import 'package:lettutor/enums/tutor_filter_choice.dart';

class TutorSearchFilterChoiceList extends StatelessWidget {
  const TutorSearchFilterChoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    TutorFilterChoice chosen = TutorFilterChoice.all;
    return Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: TutorFilterChoice.values
            .map((e) => SizedBox(
                  height: 32,
                  child: ChoiceChip(
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    showCheckmark: false,
                    backgroundColor: const Color.fromARGB(255, 228, 230, 235),
                    selectedColor: const Color.fromARGB(255, 221, 234, 255),
                    label: Text(e.name),
                    onSelected: (bool selected) {},
                    selected: e == chosen,
                    labelStyle: TextStyle(color: MaterialStateColor.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return Theme.of(context)
                              .primaryColor; // Text color when selected
                        }
                        return const Color.fromARGB(
                            255, 100, 100, 100); // Text color when not selected
                      },
                    )),
                  ),
                ))
            .toList());
  }
}
