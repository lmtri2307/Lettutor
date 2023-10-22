import 'package:flutter/material.dart';

class TimeRangePickerFormField extends StatelessWidget {
  const TimeRangePickerFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(24)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "16:00",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  enabledBorder: InputBorder.none,
                  // border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  )),
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
              },
            ),
          ),
          Icon(Icons.arrow_right_alt_sharp, color: Colors.grey.shade500),
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                  hintText: "23:59",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  enabledBorder: InputBorder.none,
                  // border: InputBorder.none,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  )),
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );
              },
            ),
          ),
          Icon(Icons.access_time_sharp, color: Colors.grey.shade300),
        ],
      ),
    );
  }
}