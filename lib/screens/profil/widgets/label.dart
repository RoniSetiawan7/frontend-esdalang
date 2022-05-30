import 'package:flutter/material.dart';

class MyLabel extends StatelessWidget {
  final String text;
  final String? required;
  const MyLabel({Key? key, required this.text, this.required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16, bottom: 3),
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5, bottom: 3),
          child: Text(required ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red)),
        ),
      ],
    );
  }
}
