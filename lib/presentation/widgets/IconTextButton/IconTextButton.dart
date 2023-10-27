import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton(
      {super.key,
      required this.iconData,
      required this.label,
      this.color,
      required this.onPressed});

  final IconData iconData;
  final String label;
  final Color? color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: color ?? Theme.of(context).primaryColor,
            ),
            Text(label,
                style:
                    TextStyle(color: color ?? Theme.of(context).primaryColor))
          ],
        ),
      ),
    );
  }
}
