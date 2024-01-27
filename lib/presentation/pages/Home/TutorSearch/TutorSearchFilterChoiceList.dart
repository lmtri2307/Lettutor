import 'package:flutter/material.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/presentation/widgets/MultipleLabelsPicker/MultipleLabelPicker.dart';
import 'package:lettutor/service/TutorService.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TutorSearchFilterChoiceList extends StatelessWidget {
  TutorSearchFilterChoiceList(
      {super.key, required this.onSearchSpecialty});

  final void Function(Specialty specialty) onSearchSpecialty;
  final TutorService _tutorService = const TutorService();
  final GlobalKey<MultipleLabelsPickerState> pickerKey =
      GlobalKey<MultipleLabelsPickerState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
          future: _tutorService.getAllSpecialty(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return MultipleLabelsPicker(
                key: pickerKey,
                onItemSelected: onSearchSpecialty,
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
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
            style: TextButton.styleFrom(
                side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.7))),
            onPressed: () {
              pickerKey.currentState?.reset();
            },
            child: Text(
              AppLocalizations.of(context).resetResult,
              style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.7)),
            )),
      ],
    );
  }
}
