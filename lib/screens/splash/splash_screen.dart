import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/checkAuth');
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.lightBlueAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              child: Image.asset('assets/images/logo_smp.png'),
              height: size.height * 0.4,
              width: size.width * 0.5,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            alignment: Alignment.bottomCenter,
            child: Text(
              'Esdalang Mobile Learning App',
              style: const TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white)
                  .copyWith(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
