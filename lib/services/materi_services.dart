import 'dart:convert';
import 'dart:io';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/materi.dart';
import 'package:esdalang_app/services/token.dart';
import 'package:http/http.dart' as http;

class MateriServices {
  static Future<List<Materi>> getMateri(String idKelas) async {
    try {
      await getToken();
      String fullUrl = '$materiUrl/$idKelas';
      final response =
          await http.get(Uri.parse(fullUrl), headers: setHeaders());

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((materi) => Materi.fromJson(materi)).toList();
      } else {
        print(response.statusCode.toString());
        return Future.error('Gagal Memuat Data Materi :(');
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

  static Future<List<SubMateri>> getSubMateri(Materi materi) async {
    try {
      await getToken();
      String fullUrl = '$subMateriUrl/${materi.nmMateri}';
      final response =
          await http.get(Uri.parse(fullUrl), headers: setHeaders());

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((subMateri) => SubMateri.fromJson(subMateri))
            .toList();
      } else {
        print(response.statusCode.toString());
        return Future.error('Gagal Memuat Data Materi :(');
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
