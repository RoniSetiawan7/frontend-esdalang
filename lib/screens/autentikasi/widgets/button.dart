import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool loading;

  const MyButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      height: size.height * 0.07,
      minWidth: size.width * 0.88,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPressed: () => onPressed(),
      color: Colors.lightBlueAccent,
      elevation: 5,
      highlightColor: Colors.lightBlue,
      highlightElevation: 1,
      child: loading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white)),
                SizedBox(width: 10),
                Text('Mohon tunggu sebentar...',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.white))
              ],
            )
          : Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.white),
            ),
    );
  }
}
