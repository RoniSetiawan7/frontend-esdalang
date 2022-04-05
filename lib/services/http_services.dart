import 'dart:convert';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/services/token.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  static postData(data, String postUrl) async {
    var fullUrl = apiUrl + postUrl;
    print(data);
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders());
  }

  static getData(String getUrl) async {
    var fullUrl = apiUrl + getUrl;
    await getToken();
    return await http.get(Uri.parse(fullUrl), headers: setHeaders());
  }

  static putData(data, String putUrl, String id) async {
    var fullUrl = apiUrl + putUrl + id;
    print(data);
    await getToken();
    return await http.put(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders());
  }
}
