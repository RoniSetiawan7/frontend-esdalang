import 'package:flutter/material.dart';

mySnackBar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message, textAlign: TextAlign.center),
      duration: const Duration(seconds: 5),
    ),
  );
}
