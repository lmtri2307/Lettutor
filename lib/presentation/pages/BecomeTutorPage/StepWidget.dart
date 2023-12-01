import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  const StepWidget({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepTile(
            stepIndex: 0,
            currentIndex: currentIndex,
            label: "Complete Profile"),
        const SizedBox(
          height: 12,
        ),
        StepTile(
            stepIndex: 1,
            currentIndex: currentIndex,
            label: "Video Introduction"),
        const SizedBox(
          height: 12,
        ),
        StepTile(stepIndex: 2, currentIndex: currentIndex, label: "Approval"),
      ],
    );
  }
}

enum StepTileState { passed, current, notPassed }

class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.stepIndex,
    required this.currentIndex,
    required this.label,
  });

  final int stepIndex;
  final int currentIndex;
  final String label;

  String get indexLabel => (stepIndex + 1).toString();

  StepTileState get state => currentIndex == stepIndex
      ? StepTileState.current
      : currentIndex > stepIndex
          ? StepTileState.passed
          : StepTileState.notPassed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundColor: state == StepTileState.current
                ? theme.primaryColor
                : Colors.transparent,
            child: state == StepTileState.passed
                ? Icon(
                    Icons.check,
                    color: theme.primaryColor,
                  )
                : Text(
                    indexLabel,
                    style: TextStyle(
                        color: state == StepTileState.current
                            ? Colors.white
                            : Colors.grey),
                  ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(label,
            style: theme.textTheme.bodyMedium?.copyWith(
                color: state == StepTileState.current
                    ? Colors.black
                    : Colors.grey))
      ],
    );
  }
}
