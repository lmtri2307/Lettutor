import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CourseFilter extends StatelessWidget {
  const CourseFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        )),
        child: Wrap(
          direction: Axis.horizontal,
          runSpacing: 4,
          children: [
            FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(right: 8),
                    child: CourseFilterField(
                      optionList: const [
                        "Intermediate",
                        "Beginner",
                        "Pre-advanced",
                        "Upper-Beginner"
                      ],
                      label: "Select Level",
                      getOptionLabel: (option) => option,
                    ))),
            FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 8),
                    child: CourseFilterField(
                      optionList: const [
                        "Intermediate",
                        "Beginner",
                        "Pre-advanced",
                        "Upper-Beginner"
                      ],
                      label: "Select category",
                      getOptionLabel: (option) => option,
                    ))),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Sort by level"),
              isExpanded: true,
              items: ["Level decreasing", "Level ascending"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (e) {},
            ),
          ],
        ));
  }
}

class CourseFilterField<T> extends StatelessWidget {
  const CourseFilterField(
      {super.key,
      required this.label,
      required this.optionList,
      required this.getOptionLabel});

  final String label;
  final List<T> optionList;
  final String Function(T option) getOptionLabel;

  @override
  Widget build(BuildContext context) {
    final selectedOptions = optionList.sublist(0, 2);

    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: label,
        floatingLabelBehavior: selectedOptions.isNotEmpty
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.never,
        hintText: "${selectedOptions.length} selected",
      ),
      onTap: () async {
        await showDialog(
          context: context,
          builder: (ctx) {
            return MultiSelectDialog(
              title: Text(label),
              items: optionList
                  .map((option) =>
                      MultiSelectItem(option, getOptionLabel(option)))
                  .toList(),
              initialValue: selectedOptions,
              onConfirm: (values) {},
            );
          },
        );
      },
    );
  }
}
