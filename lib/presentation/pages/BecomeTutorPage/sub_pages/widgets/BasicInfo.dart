import "package:country_code_picker/country_code_picker.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/widgets/NoteContainer.dart";

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  ImageProvider? imageProvider;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: imageProvider,
            radius: 50,
            child: Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () async {},
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            )),
        const SizedBox(
          height: 14,
        ),
        NoteContainer(
          noteList: [
            TextSpan(
                text: "Please upload a professional photo. See guidelines",
                style: theme.textTheme.bodySmall)
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Tutoring name",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your name";
          },
          onChanged: (value) {},
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "I'm from",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.white54,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade600,
              width: 1,
            ),
          ),
          child: CountryCodePicker(
            // initialSelection: country,
            onChanged: (CountryCode countryCode) {},
            showOnlyCountryWhenClosed: true,
            showCountryOnly: true,
            alignLeft: true,
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Date of Birth",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          // controller: dobTextController,
          readOnly: true,
          validator: (value) {
            return value!.isNotEmpty ? null : "Please input your dob";
          },
          controller: _textController,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 10),
              lastDate: DateTime(DateTime.now().year + 10),
            );
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted = formatter.format(date!);
            _textController.text = formatted;
          },
          style: theme.textTheme.bodySmall,
          decoration: const InputDecoration(
            isDense: true,
            suffixIcon: Icon(
              Icons.calendar_month,
            ),
          ),
        ),
      ],
    );
  }
}
