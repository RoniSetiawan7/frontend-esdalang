import 'package:esdalang_app/models/siswa.dart';
import 'package:esdalang_app/screens/profil/ubah_profil.dart';
import 'package:esdalang_app/services/siswa_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TampilProfil extends StatefulWidget {
  const TampilProfil({Key? key}) : super(key: key);

  @override
  _TampilProfilState createState() => _TampilProfilState();
}

class _TampilProfilState extends State<TampilProfil> {
  Future<Siswa>? _siswa;

  @override
  void initState() {
    super.initState();
    _siswa = SiswaServices.getSiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: 'Profil'),
      body: MyBackground(
        child: Center(
          child: SingleChildScrollView(
            child: FutureBuilder<Siswa>(
              future: _siswa,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Siswa? siswa = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue,
                        child: Text(
                          siswa.nmSiswa[0].toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 36),
                        ),
                      ),
                      Container(
                        height: 48,
                        margin: const EdgeInsets.only(left: 205),
                        child: FloatingActionButton.extended(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/ubahProfil',
                                  arguments: UbahProfil(
                                      siswa: Siswa(
                                    nis: siswa.nis,
                                    nmSiswa: siswa.nmSiswa,
                                    jk: siswa.jk,
                                    tempatLahir: siswa.tempatLahir,
                                    tglLahir: siswa.tglLahir,
                                    agama: siswa.agama,
                                    alamat: siswa.alamat,
                                    noTelp: siswa.noTelp,
                                    idKelas: siswa.idKelas,
                                    subKelas: siswa.subKelas,
                                  ))),
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text(
                            'Perbarui',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _userDetail(
                          'NIS                      :', siswa.nis.toString()),
                      _userDetail('Nama                  :', siswa.nmSiswa),
                      _userDetail(
                        'Kelas                   :',
                        (siswa.idKelas == '7')
                            ? 'Tujuh'
                            : (siswa.idKelas == '8')
                                ? 'Delapan'
                                : (siswa.idKelas == '9')
                                    ? 'Sembilan'
                                    : '-',
                      ),
                      _userDetail(
                          'Sub Kelas          :', siswa.subKelas ?? '-'),
                      _userDetail(
                        'Jenis Kelamin   :',
                        (siswa.jk == 'L')
                            ? 'Laki-laki'
                            : (siswa.jk == 'P')
                                ? 'Perempuan'
                                : '-',
                      ),
                      _userDetail(
                          'Tempat Lahir     :', siswa.tempatLahir ?? '-'),
                      _userDetail(
                          'Tanggal Lahir    :',
                          siswa.tglLahir == null
                              ? '-'
                              : DateFormat('dd MMMM yyyy').format(
                                  DateTime.parse(
                                      '${siswa.tglLahir}'.split(' ')[0]))),
                      _userDetail('Agama                :', siswa.agama ?? '-'),
                      _userDetail(
                          'Alamat                :', siswa.alamat ?? '-'),
                      _userDetail(
                          'No. Telp              :', siswa.noTelp ?? '-'),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  );
                }
                return const MyLoading();
              },
            ),
          ),
        ),
      ),
    );
  }
}

_userDetail(String text1, text2) {
  return Container(
    margin: const EdgeInsets.only(left: 4, right: 4),
    height: 65,
    child: Card(
      elevation: 4,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              text1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(text2, softWrap: true),
            ),
          )
        ],
      ),
    ),
  );
}
