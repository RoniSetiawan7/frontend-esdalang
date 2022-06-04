import 'dart:convert';

import 'package:esdalang_app/models/latihan.dart';
import 'package:esdalang_app/services/latihan_services.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:esdalang_app/widgets/background.dart';
import 'package:esdalang_app/widgets/loading.dart';
import 'package:esdalang_app/widgets/no_data_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'functions/pilih.dart';

class ListLatihan extends StatefulWidget {
  const ListLatihan({Key? key}) : super(key: key);

  @override
  _ListLatihanState createState() => _ListLatihanState();
}

class _ListLatihanState extends State<ListLatihan> {
  Future<List<Latihan>>? _latihan;
  int? idKelas;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _loadIdKelas();
      await _loadLatihan();
    });
  }

  _loadIdKelas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var idKelasSiswa = jsonDecode(prefs.getString('id_kelas')!);

    setState(() {
      idKelas = idKelasSiswa;
    });
  }

  _loadLatihan() {
    _latihan = LatihanServices.getLatihan('$idKelas');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: (idKelas == 7)
              ? 'List Latihan - Kelas Tujuh'
              : (idKelas == 8)
                  ? 'List Latihan - Kelas Delapan'
                  : 'List Latihan - Kelas Sembilan'),
      body: MyBackground(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: FutureBuilder<List<Latihan>>(
            future: _latihan,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Latihan>? latihan = snapshot.data!;
                return latihan.isEmpty
                    ? const MyNoDataFound()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: latihan.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(latihan[index].nmLatihan),
                              subtitle: Text('Guru : ' + latihan[index].nmGuru),
                              onTap: () async => showDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Column(
                                    children: [
                                      Text(latihan[index].nmLatihan),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                  content: Pilih(latihan: latihan[index]),
                                ),
                              ),
                            ),
                          );
                        },
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
    );
  }
}
