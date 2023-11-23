import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.removeCurrentSnackBar();
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.pink[50],
      showCloseIcon: true,
      closeIconColor: Colors.red,
      content: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 16.0),
          // Give some spacing between the icon and the text
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String text) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.removeCurrentSnackBar();
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green[50],
      showCloseIcon: true,
      closeIconColor: Colors.green,
      content: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 16.0),
          // Give some spacing between the icon and the text
          Flexible(
            child: Text(
              text,
              style: const TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    ),
  );
}
