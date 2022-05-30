import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String? initialValue;
  final String? Function(String?) validator;
  final bool readOnly;
  const MyTextField(
      {Key? key,
      required this.hint,
      required this.initialValue,
      required this.validator,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 15),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          hintText: hint,
        ),
        validator: validator,
      ),
    );
  }
}
