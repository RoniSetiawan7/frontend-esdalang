import 'package:flutter/material.dart';

AppBar myAppBar(
    {required BuildContext context,
    required String title,
    List<Widget>? actions}) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.lightBlueAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
    ),
    actions: actions,
  );
}
