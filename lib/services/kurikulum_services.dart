import 'dart:convert';
import 'dart:io';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/kurikulum.dart';
import 'package:esdalang_app/services/token.dart';
import 'package:http/http.dart' as http;

class KurikulumServices {
  static Future<List<Kurikulum>> getKurikulum(String idKelas) async {
    try {
      await getToken();
      String fullUrl = '$kurikulumUrl/$idKelas';
      final response =
          await http.get(Uri.parse(fullUrl), headers: setHeaders());

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((kurikulum) => Kurikulum.fromJson(kurikulum))
            .toList();
      } else {
        print(response.statusCode.toString());
        return Future.error('Gagal Memuat Data Kurikulum :(');
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
