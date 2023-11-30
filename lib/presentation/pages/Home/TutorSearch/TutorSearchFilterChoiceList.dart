import 'package:flutter/material.dart';
import 'package:lettutor/dummy/specialty.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';
import 'package:lettutor/providers/TutorListProvider.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:provider/provider.dart';

class TutorSearchFilterChoiceList extends StatelessWidget {
  const TutorSearchFilterChoiceList({super.key});

  final TutorService tutorService = const TutorService();

  @override
  Widget build(BuildContext context) {
    final tutorListProvider = context.read<TutorListProvider>();
    return FutureBuilder(
      future: tutorService.getAllSpecialty(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return MultipleLabelsPicker(
            onItemSelected: (specialty) async {
              tutorListProvider
                  .setTutorListFuture(tutorService.searchByFilter(specialty));
            },
            itemList: [Specialty.all, ...?snapshot.data],
            getLabelFromItem: (specialty) => specialty.name,
            // labelList: ["All", ...specialtyList.map((e) => e.name).toList()],
            defaultStyle: StateStyle(
                backgroundColor: const Color.fromARGB(255, 228, 230, 235),
                textColor: const Color.fromARGB(255, 100, 100, 100)),
            selectedStyle: StateStyle(
                backgroundColor: const Color.fromARGB(255, 221, 234, 255),
                textColor: Theme.of(context).primaryColor));
      },
    );
  }
}
