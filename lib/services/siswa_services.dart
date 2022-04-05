import 'dart:convert';
import 'dart:io';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/siswa.dart';
import 'package:esdalang_app/services/token.dart';
import 'package:http/http.dart' as http;

class SiswaServices {
  static Future<Siswa> getSiswa() async {
    try {
      await getToken();
      final response =
          await http.get(Uri.parse(profilUrl), headers: setHeaders());

      if (response.statusCode == 200) {
        print(response.body);
        return Siswa.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode.toString());
        return Future.error('Gagal Memuat Data Siswa :(');
      }
    } on SocketException {
      return Future.error('Tidak Ada Koneksi Internet :(');
    } on HttpException {
      return Future.error('Layanan Tidak Ditemukan :(');
    } on FormatException {
      return Future.error('Format Data Tidak Valid :(');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
