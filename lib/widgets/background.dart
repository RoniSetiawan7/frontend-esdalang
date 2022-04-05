import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const MyBackground({Key? key, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      padding: padding,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill),
      ),
      child: child,
    );
  }
}
