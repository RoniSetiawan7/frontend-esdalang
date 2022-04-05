import 'package:flutter/material.dart';

class LatihanListTile extends StatelessWidget {
  final String leading;
  final String trailing;
  const LatihanListTile(
      {Key? key, required this.leading, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: Text(
          leading,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        trailing: Text(
          trailing,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
