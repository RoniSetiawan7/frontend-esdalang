import 'package:esdalang_app/functions/check_auth.dart';
import 'package:esdalang_app/screens/autentikasi/halaman_login.dart';
import 'package:esdalang_app/screens/autentikasi/halaman_registrasi.dart';
import 'package:esdalang_app/screens/halaman_utama/halaman_utama.dart';
import 'package:esdalang_app/screens/info/info_aplikasi.dart';
import 'package:esdalang_app/screens/kurikulum/list_kurikulum.dart';
import 'package:esdalang_app/screens/kurikulum/menu_kurikulum.dart';
import 'package:esdalang_app/screens/kurikulum/tampil_kurikulum.dart';
import 'package:esdalang_app/screens/latihan/hasil_latihan.dart';
import 'package:esdalang_app/screens/latihan/list_latihan.dart';
import 'package:esdalang_app/screens/latihan/pembahasan_latihan.dart';
import 'package:esdalang_app/screens/latihan/tampil_latihan.dart';
import 'package:esdalang_app/screens/latihan/tampil_materi_latihan.dart';
import 'package:esdalang_app/screens/materi/list_materi.dart';
import 'package:esdalang_app/screens/materi/list_sub_materi.dart';
import 'package:esdalang_app/screens/materi/menu_materi.dart';
import 'package:esdalang_app/screens/materi/tampil_materi.dart';
import 'package:esdalang_app/screens/profil/tampil_profil.dart';
import 'package:esdalang_app/screens/profil/ubah_profil.dart';
import 'package:esdalang_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    //* Fungsi Cek Autentikasi User
    switch (settings.name) {
      case '/checkAuth':
        return MaterialPageRoute(
            builder: (BuildContext context) => const CheckAuth());

      //* Route Splash Screen
      case '/splashScreen':
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      //* Route Halaman Utama
      case '/halamanUtama':
        return MaterialPageRoute(
            builder: (BuildContext context) => const HalamanUtama());

      //* Route Info Aplikasi
      case '/infoAplikasi':
        return MaterialPageRoute(
            builder: (BuildContext context) => const InfoAplikasi());

      //* Route Autentikasi User
      case '/halamanLogin':
        return MaterialPageRoute(
            builder: (BuildContext context) => const HalamanLogin());
      case '/halamanRegistrasi':
        return MaterialPageRoute(
            builder: (BuildContext context) => const HalamanRegistrasi());

      //* Route Menu Profil
      case '/tampilProfil':
        return MaterialPageRoute(
            builder: (BuildContext context) => const TampilProfil());
      case '/ubahProfil':
        return MaterialPageRoute(
          builder: (context) {
            UbahProfil argument = args as UbahProfil;
            return UbahProfil(
              siswa: argument.siswa,
            );
          },
        );

      //* Route Menu Materi
      case '/menuMateri':
        return MaterialPageRoute(
            builder: (BuildContext context) => const MenuMateri());
      case '/listMateriKelas7':
        return MaterialPageRoute(
            builder: (BuildContext context) => const ListMateri(idKelas: '7'));
      case '/listMateriKelas8':
        return MaterialPageRoute(
            builder: (BuildContext context) => const ListMateri(idKelas: '8'));
      case '/listMateriKelas9':
        return MaterialPageRoute(
            builder: (BuildContext context) => const ListMateri(idKelas: '9'));
      case '/listSubMateri':
        return MaterialPageRoute(
          builder: (context) {
            ListSubMateri argument = args as ListSubMateri;
            return ListSubMateri(
              materi: argument.materi,
            );
          },
        );
      case '/tampilMateri':
        return MaterialPageRoute(
          builder: (context) {
            TampilMateri argument = args as TampilMateri;
            return TampilMateri(
              subMateri: argument.subMateri,
            );
          },
        );

      //* Route Menu Kurikulum
      case '/menuKurikulum':
        return MaterialPageRoute(
            builder: (BuildContext context) => const MenuKurikulum());
      case '/listKurikulumKelas7':
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const ListKurikulum(idKelas: '7'));
      case '/listKurikulumKelas8':
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const ListKurikulum(idKelas: '8'));
      case '/listKurikulumKelas9':
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const ListKurikulum(idKelas: '9'));
      case '/tampilKurikulum':
        return MaterialPageRoute(
          builder: (context) {
            TampilKurikulum argument = args as TampilKurikulum;
            return TampilKurikulum(
              kurikulum: argument.kurikulum,
            );
          },
        );

      //* Route Menu Latihan
      case '/listLatihan':
        return MaterialPageRoute(
            builder: (BuildContext context) => const ListLatihan());
      case '/tampilLatihan':
        return MaterialPageRoute(
          builder: (context) {
            TampilLatihan argument = args as TampilLatihan;
            return TampilLatihan(
              latihan: argument.latihan,
              pertanyaan: argument.pertanyaan,
            );
          },
        );
      case '/hasilLatihan':
        return MaterialPageRoute(
          builder: (context) {
            HasilLatihan argument = args as HasilLatihan;
            return HasilLatihan(
              pertanyaan: argument.pertanyaan,
              jawaban: argument.jawaban,
            );
          },
        );
      case '/pembahasanLatihan':
        return MaterialPageRoute(
          builder: (context) {
            PembahasanLatihan argument = args as PembahasanLatihan;
            return PembahasanLatihan(
              pertanyaan: argument.pertanyaan,
              jawaban: argument.jawaban,
            );
          },
        );
      case '/tampilMateriLatihan':
        return MaterialPageRoute(
          builder: (context) {
            TampilMateriLatihan argument = args as TampilMateriLatihan;
            return TampilMateriLatihan(
              pertanyaan: argument.pertanyaan,
            );
          },
        );

      //* Jika Nama Route Tidak Ditemukan
      default:
        return null;
    }
  }
}
