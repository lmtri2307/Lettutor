import 'package:flutter/material.dart';
import 'package:lettutor/models/Nationality.dart';
import 'package:lettutor/presentation/pages/Home/TutorSearch/TutorSearchFilterChoiceList.dart';
import 'package:lettutor/presentation/widgets/TimeRangePickerFormField/TimeRangePickerFormField.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

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
        TutorSearchForm(),
      ],
    );
  }
}

class TutorSearchForm extends StatelessWidget {
  TutorSearchForm({super.key});

  final _searchFormData = TutorSearchFormData();
  final _tutorService = const TutorService();

  void _onSearchTutor(TutorListProvider tutorListProvider) async {
    tutorListProvider.searchTutorList(_searchFormData);
  }

  @override
  Widget build(BuildContext context) {
    final tutorListProvider = context.read<TutorListProvider>();
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
                onChanged: (value) {
                  _searchFormData.name = value;
                  _onSearchTutor(tutorListProvider);
                },
                decoration: const InputDecoration(
                  hintText: "Enter tutor name...",
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: _tutorService.getAllNationality(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return FractionallySizedBox(
                widthFactor: 0.4,
                child: SizedBox(
                  height: 32,
                  child: DropdownButtonFormField<Nationality>(
                    isExpanded: true,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                            value: e, child: Text("${e.name} Tutor")))
                        .toList(),
                    onChanged: (nationality) {
                      _searchFormData.tutorNationality = nationality;
                      _onSearchTutor(tutorListProvider);
                    },
                  ),
                ),
              );
            },
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
          TutorSearchFilterChoiceList(
            onSearchSpecialty: (specialty) {
              _searchFormData.specialty = specialty;
              _onSearchTutor(tutorListProvider);
            },
          ),
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
