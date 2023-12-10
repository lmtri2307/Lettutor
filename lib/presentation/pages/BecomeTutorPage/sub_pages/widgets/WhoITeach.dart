import 'package:flutter/material.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/NoteContainer.dart';
import 'package:lettutor/service/TutorService.dart';

class WhoITeach extends StatelessWidget {
  const WhoITeach({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NoteContainer(
          noteList: [
            TextSpan(
                text:
                    "This is the first thing students will see when looking for tutors.",
                style: theme.textTheme.bodySmall)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Introduction",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          minLines: 1,
          maxLines: 5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your introduction";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "I am best at teaching students who are",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        const LevelChoosingRadio(),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "My specialties are",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        const SpecialtyChoosing(),
      ],
    );
  }
}

class LevelChoosingRadio extends StatefulWidget {
  const LevelChoosingRadio({super.key});

  @override
  State<LevelChoosingRadio> createState() => _LevelChoosingRadioState();
}

class _LevelChoosingRadioState extends State<LevelChoosingRadio> {
  String _chosen = 'Beginner';

  void onChoose(value) {
    setState(() {
      _chosen = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(value: 'Beginner', groupValue: _chosen, onChanged: onChoose),
            Text(
              "Beginner",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(
                value: 'Intermediate',
                groupValue: _chosen,
                onChanged: onChoose),
            Text(
              "Intermediate",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio(value: 'Advanced', groupValue: _chosen, onChanged: onChoose),
            Text(
              "Advanced",
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

class SpecialtyChoosing extends StatefulWidget {
  const SpecialtyChoosing({super.key});

  @override
  State<SpecialtyChoosing> createState() => _SpecialtyChoosingState();
}

class _SpecialtyChoosingState extends State<SpecialtyChoosing> {
  List<Specialty>? specialtyList;
  final List<Specialty> _chosenList = [];

  @override
  Widget build(BuildContext context) {
    if (specialtyList == null) {
      const TutorService().getAllSpecialty().then((value) {
        if(mounted){
          setState(() {
            specialtyList = value;
          });
        }

      });
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final theme = Theme.of(context);
    return ListBody(
      children: List<Widget>.generate(specialtyList!.length, (index) {
        final specialty = specialtyList![index];
        return CheckboxListTile(
            dense: true,
            visualDensity:
                const VisualDensity(horizontal: -4.0, vertical: -4.0),
            contentPadding: EdgeInsets.zero,
            value: _chosenList.contains(specialty),
            title: Text(
              specialty.name,
              style: theme.textTheme.bodySmall,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (isChecked) {
              if (isChecked!) {
                setState(() {
                  _chosenList.add(specialty);
                });
              } else {
                setState(() {
                  _chosenList.remove(specialty);
                });
              }
            });
      }),
    );
  }
}
