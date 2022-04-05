import 'package:esdalang_app/screens/autentikasi/halaman_login.dart';
import 'package:esdalang_app/screens/halaman_utama/halaman_utama.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool _isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      setState(() {
        _isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    _isAuth ? child = const HalamanUtama() : child = const HalamanLogin();
    return Scaffold(
      body: child,
    );
  }
}
