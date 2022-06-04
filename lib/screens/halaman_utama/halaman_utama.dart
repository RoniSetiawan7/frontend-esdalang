import 'dart:convert';

import 'package:esdalang_app/services/http_services.dart';
import 'package:esdalang_app/widgets/grid.dart';
import 'package:esdalang_app/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int? idKelas, nis;
  String? nama, subKelas;

  @override
  void initState() {
    super.initState();
    _loadDataSiswa();
  }

  _loadDataSiswa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nisSiswa = jsonDecode(prefs.getString('nis')!);
    var namaSiswa = jsonDecode(prefs.getString('nm_siswa')!);
    var idKelasSiswa = jsonDecode(prefs.getString('id_kelas')!);
    var subKelasSiswa = jsonDecode(prefs.getString('sub_kelas')!);

    setState(() {
      nis = nisSiswa;
      nama = namaSiswa;
      idKelas = idKelasSiswa;
      subKelas = subKelasSiswa;
    });
  }

  _showSuccessMsg(msg) {
    mySnackBar(
        context: context, message: '✔   ' + msg, color: Colors.green.shade400);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent,
                        Colors.lightBlueAccent,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                flex: 5,
              ),
            ],
          ),
          Column(
            children: [
              ListTile(
                contentPadding:
                    const EdgeInsets.only(left: 16, right: 16, top: 40),
                title: Text(
                  '$nama',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 20),
                ),
                subtitle: Text(
                  'NIS : $nis | Kelas : $idKelas $subKelas',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15),
                ),
                trailing: GestureDetector(
                  onTap: () => _showLogoutDialog(),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      '$nama'[0].toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: GridView.extent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: .85,
                    children: [
                      MyGrid(
                        text: 'Materi',
                        imageUrl: 'assets/icons/materi.png',
                        onTap: () =>
                            Navigator.pushNamed(context, '/menuMateri'),
                      ),
                      MyGrid(
                        text: 'Latihan',
                        imageUrl: 'assets/icons/latihan.png',
                        onTap: () =>
                            Navigator.pushNamed(context, '/listLatihan'),
                      ),
                      MyGrid(
                        text: 'Kurikulum',
                        imageUrl: 'assets/icons/kurikulum.png',
                        onTap: () =>
                            Navigator.pushNamed(context, '/menuKurikulum'),
                      ),
                      MyGrid(
                        text: 'Profil',
                        imageUrl: 'assets/icons/profil.png',
                        onTap: () =>
                            Navigator.pushNamed(context, '/tampilProfil'),
                      ),
                      MyGrid(
                        text: 'Info Aplikasi',
                        imageUrl: 'assets/icons/info_aplikasi.png',
                        onTap: () =>
                            Navigator.pushNamed(context, '/infoAplikasi'),
                      ),
                      MyGrid(
                        text: 'Keluar',
                        imageUrl: 'assets/icons/keluar.png',
                        onTap: () => _showCloseDialog(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _logout() async {
    var res = await HttpServices.getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('nis');
      prefs.remove('nm_siswa');
      prefs.remove('id_kelas');
      prefs.remove('sub_kelas');

      _showSuccessMsg(body['message']);
      Navigator.pushNamedAndRemoveUntil(
          context, '/halamanLogin', (Route<dynamic> route) => false);
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah anda ingin logout dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => _logout(),
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }

  void _showCloseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah anda ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: const Text('Ya'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tidak'),
            ),
          ],
        );
      },
    );
  }
}
