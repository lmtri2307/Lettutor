import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SlotWidget extends StatelessWidget {
  const SlotWidget(
      {super.key, required this.startTime, required this.endTime, required this.isAvailable});

  final bool isAvailable;
  final DateTime startTime;
  final DateTime endTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilledButton(
      style: FilledButton.styleFrom(
        // shape: const RoundedRectangleBorder(),
          alignment: Alignment.centerLeft,
          // surfaceTintColor: isAvailable ? theme.primaryColor : Colors.grey,
          backgroundColor: isAvailable ? theme.primaryColor : Colors.grey
      ),
      onPressed: isAvailable ? () {} : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              isAvailable ? "Available" : "Reserved",
              style: TextStyle(
                color: isAvailable ? Colors.white : Colors.grey.shade500,
              ),
            ),
          ),
          Text(
            "${DateFormat("HH:mm").format(startTime)} - ${DateFormat("HH:mm")
                .format(endTime)}",
            style: Theme
                .of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                color: isAvailable ? Colors.white : Colors.grey.shade500),
          )
        ],
      ),
    );
  }
}