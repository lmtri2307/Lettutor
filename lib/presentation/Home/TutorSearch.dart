import 'package:flutter/material.dart';
import 'package:lettutor/enums/tutor_nationality.dart';
import 'package:lettutor/presentation/Home/TutorSearchFilterChoiceList.dart';
import 'package:lettutor/presentation/TimeRangePickerFormField/TimeRangePickerFormField.dart';

class TutorSearch extends StatelessWidget {
  const TutorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Find a tutor",
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        const TutorSearchForm(),
      ],
    );
  }
}

class TutorSearchForm extends StatelessWidget {
  const TutorSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Colors.grey.shade300,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 11),
        hintStyle: TextStyle(color: Colors.grey.shade300),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(24))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      )),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FractionallySizedBox(
              widthFactor: 0.6,
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter tutor name...",
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          FractionallySizedBox(
            widthFactor: 0.4,
            child: SizedBox(
              height: 32,
              child: DropdownButtonFormField<TutorNationality>(
                isExpanded: true,
                items: TutorNationality.values
                    .map((e) => DropdownMenuItem(
                        value: e, child: Text("${e.name} Tutor")))
                    .toList(),
                onChanged: (e) {},
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Select available tutoring time:",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: SizedBox(
              height: 32,
              child: TextFormField(
                // readOnly: true,
                decoration: const InputDecoration(
                  hintText: "Select a day",
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime(DateTime.now().year + 10),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const FractionallySizedBox(
            widthFactor: 0.8,
            child: TimeRangePickerFormField(),
          ),
          const SizedBox(
            height: 10,
          ),
          const TutorSearchFilterChoiceList(),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              style: TextButton.styleFrom(
                  side: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.7))),
              onPressed: () {},
              child: Text(
                "Reset result",
                style: TextStyle(
                    color: Theme.of(context).primaryColor.withOpacity(0.7)),
              )),
        ],
      )),
    );
  }
}
