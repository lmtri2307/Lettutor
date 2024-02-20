import 'package:flutter/material.dart';
import 'package:lettutor/models/Category.dart';
import 'package:lettutor/presentation/pages/CoursesPage/CoursesPage.dart';
import 'package:lettutor/repository/CourseRepository.dart';
import 'package:lettutor/service/CourseService.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseFilter extends StatelessWidget {
  const CourseFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final courseFormProvider = context.read<CourseFormProvider>();
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
          labelStyle: TextStyle(color: Colors.grey.shade400),
          hintStyle: TextStyle(color: Colors.grey.shade400),
        )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context).filters,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              direction: Axis.horizontal,
              runSpacing: 4,
              children: [
                FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(right: 8),
                        child: CourseFilterField(
                          optionList: LevelMapper.getAllLevels(),
                          label: AppLocalizations.of(context).selectLevel,
                          getOptionLabel: (option) => option.name,
                          onSelected: (selectedOptions) {
                            courseFormProvider.setLevels(selectedOptions);
                          },
                        ))),
                FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Container(
                        height: 40,
                        margin: const EdgeInsets.only(left: 8),
                        child: FutureBuilder(
                          future: const CourseService().getAllCategories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CourseFilterField(
                                optionList: snapshot.data as List<Category>,
                                label: AppLocalizations.of(context).selectCategory,
                                getOptionLabel: (option) => option.name,
                                onSelected: (selectedOptions) {
                                  courseFormProvider
                                      .setCategories(selectedOptions);
                                },
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ))),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: "Sort by level"),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                        value: null,
                        child: Text(
                          AppLocalizations.of(context).noSort,
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontStyle: FontStyle.italic),
                        )),
                    ...[false, true]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                                e ? "Level ascending" : "Level decreasing")))
                        .toList()
                  ],
                  onChanged: (e) {
                    courseFormProvider.setIsAscending(e);
                  },
                ),
              ],
            ),
          ],
        ));
  }
}

class CourseFilterField<T> extends StatefulWidget {
  const CourseFilterField(
      {super.key,
      required this.label,
      required this.optionList,
      required this.getOptionLabel,
      required this.onSelected});

  final String label;
  final List<T> optionList;
  final String Function(T option) getOptionLabel;
  final Function(List<T> selectedOptions) onSelected;

  @override
  State<CourseFilterField<T>> createState() => _CourseFilterFieldState<T>();
}

class _CourseFilterFieldState<T> extends State<CourseFilterField<T>> {
  final selectedOptions = <T>[];

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        labelText: widget.label,
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
              title: Text(widget.label),
              items: widget.optionList
                  .map((option) =>
                      MultiSelectItem(option, widget.getOptionLabel(option)))
                  .toList(),
              initialValue: selectedOptions,
              onConfirm: (values) {
                setState(() {
                  selectedOptions.clear();
                  selectedOptions.addAll(values);
                  widget.onSelected(selectedOptions);
                });
              },
            );
          },
        );
      },
    );
  }
}
