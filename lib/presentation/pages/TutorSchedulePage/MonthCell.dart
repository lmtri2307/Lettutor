import 'package:flutter/material.dart';

class MonthCell extends StatelessWidget {
  const MonthCell({super.key, required this.markerColor, required this.date});

  final Color markerColor;
  final DateTime date;

  bool get isToday {
    final now = DateTime.now();
    return date.day == now.day &&
        date.month == now.month &&
        date.year == now.year;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          // Border color
          width: 1.0, // Border width
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            date.day.toString(),
            textAlign: TextAlign.center,
          ),
          Text(
            isToday ? "Today" : "",
            style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic, color: Colors.grey.shade400),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: markerColor,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}