import 'package:flutter/material.dart';

class StateStyle {
  StateStyle({required this.backgroundColor, required this.textColor});

  final Color backgroundColor;
  final Color textColor;
}

class MultipleLabelsPicker<T> extends StatefulWidget {
  const MultipleLabelsPicker({
    super.key,
    required this.defaultStyle,
    required this.selectedStyle,
    required this.onItemSelected,
    required this.itemList,
    required this.getLabelFromItem,
  });

  final List<T> itemList;
  final String Function(T item) getLabelFromItem;
  final StateStyle defaultStyle;
  final StateStyle selectedStyle;
  final void Function(T item) onItemSelected;

  @override
  State<MultipleLabelsPicker> createState() => MultipleLabelsPickerState<T>();
}

class MultipleLabelsPickerState<T> extends State<MultipleLabelsPicker<T>> {
  int _chosenIndex = 0;

  void reset() {
    setState(() {
      onSelect(widget.itemList[0]);
    });
  }

  void onSelect(T item){
    setState(() {
      _chosenIndex = widget.itemList.indexOf(item);
    });
    widget.onItemSelected(item);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: widget.itemList
            .asMap()
            .map((index, item) => MapEntry(
                index,
                SizedBox(
                  height: 32,
                  child: ChoiceChip(
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    showCheckmark: false,
                    backgroundColor: widget.defaultStyle.backgroundColor,
                    selectedColor: widget.selectedStyle.backgroundColor,
                    label: Text(widget.getLabelFromItem(item)),
                    onSelected: (isSelected) {
                      if (isSelected) {
                        onSelect(item);
                      }
                    },
                    selected: _chosenIndex == index,
                    labelStyle: TextStyle(color: MaterialStateColor.resolveWith(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return widget.selectedStyle
                              .textColor; // Text color when selected
                        }
                        return widget.defaultStyle
                            .textColor; // Text color when not selected
                      },
                    )),
                  ),
                )))
            .values
            .toList());
  }
}
