import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

String? token;

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenUser = prefs.getString('token');
  token = jsonDecode(tokenUser!);
  return token;
}

setHeaders() {
  return {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token'
  };
}
