import 'package:flutter/material.dart';

class MyUserDetail extends StatelessWidget {
  final String text1, text2;
  const MyUserDetail({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 75,
      child: Card(
        elevation: 5,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                text1,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(text2, softWrap: true),
              ),
            )
          ],
        ),
      ),
    );
  }
}
