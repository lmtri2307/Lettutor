import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class LanguageISpeak extends StatefulWidget {
  const LanguageISpeak({super.key});

  @override
  State<LanguageISpeak> createState() => _LanguageISpeakState();
}

class _LanguageISpeakState extends State<LanguageISpeak> {
  final _items = codes
      .map((json) => CountryCode.fromJson(json))
      .map((e) => MultiSelectItem<CountryCode>(e, e.name!))
      .toList();
  var _chosen = <CountryCode>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Languages",
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        MultiSelectDialogField<CountryCode>(
          initialValue: _chosen,
          searchable: true,
          chipDisplay: MultiSelectChipDisplay(

            onTap: (p0) {
              setState(() {
                _chosen = _chosen.where((element) => element.name != p0.name).toList();
              });
            },
          ),
          title: const Text("Languages"),
          decoration: BoxDecoration(
            // color: Colors.white54,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade600,
              width: 1,
            ),
          ),
          selectedColor: theme.primaryColor,
          searchHintStyle: const TextStyle(color: Colors.black),
          buttonText: const Text("Select languages"),
          items: _items,
          listType: MultiSelectListType.LIST,
          validator: (value) {
            return _chosen.isNotEmpty ? null : "Please input your languages";
          },
          onConfirm: (values) {
            setState(() {
              _chosen = values;
            });
          },
        ),
      ],
    );
  }
}
