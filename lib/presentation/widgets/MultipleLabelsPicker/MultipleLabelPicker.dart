import 'package:flutter/material.dart';

class StateStyle {
  StateStyle({required this.backgroundColor, required this.textColor});

  final Color backgroundColor;
  final Color textColor;
}

class MultipleLabelsPicker extends StatelessWidget {
  const MultipleLabelsPicker(
      {super.key,
      required this.labelList,
      required this.defaultStyle,
      required this.selectedStyle,
      required this.onSelected});

  final List<String> labelList;
  final StateStyle defaultStyle;
  final StateStyle selectedStyle;
  final void Function(bool isSlected) onSelected;

  @override
  Widget build(BuildContext context) {
    String chosen = labelList[0];
    return Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: labelList
            .map((label) => SizedBox(
                  height: 32,
                  child: ChoiceChip(
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    showCheckmark: false,
                    backgroundColor: defaultStyle.backgroundColor,
                    selectedColor: selectedStyle.backgroundColor,
                    label: Text(label),
                    onSelected: onSelected,
                    selected: label == chosen,
                    labelStyle: TextStyle(color: MaterialStateColor.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return selectedStyle
                              .textColor; // Text color when selected
                        }
                        return defaultStyle
                            .textColor; // Text color when not selected
                      },
                    )),
                  ),
                ))
            .toList());
  }
}
