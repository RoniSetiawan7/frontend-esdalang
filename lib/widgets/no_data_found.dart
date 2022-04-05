import 'package:flutter/material.dart';

class MyNoDataFound extends StatelessWidget {
  const MyNoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width,
        child: Image.asset('assets/images/no_data_found.png'),
      ),
    );
  }
}
