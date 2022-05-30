import 'dart:convert';

import 'package:esdalang_app/models/latihan.dart';
import 'package:esdalang_app/models/nilai.dart';
import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/screens/latihan/tampil_latihan.dart';
import 'package:esdalang_app/services/nilai_services.dart';
import 'package:esdalang_app/services/pertanyaan_services.dart';
import 'package:esdalang_app/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pilih extends StatefulWidget {
  final Latihan latihan;
  const Pilih({Key? key, required this.latihan}) : super(key: key);

  @override
  _PilihState createState() => _PilihState();
}

class _PilihState extends State<Pilih> {
  bool _isLoading = false;
  int? nis;

  Future<List<Nilai>>? _nilai;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await _loadDataSiswa();
      await _loadNilai();
    });
  }

  _loadDataSiswa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nisSiswa = jsonDecode(prefs.getString('nis')!);

    setState(() {
      nis = nisSiswa;
    });
  }

  _loadNilai() {
    _nilai = NilaiServices.getNilai(widget.latihan, nis.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<Nilai>>(
        future: _nilai,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Nilai>? nilai = snapshot.data!;
            return Column(
              children: [
                nilai.isEmpty
                    ? _isLoading
                        ? _circularProgressIndicator()
                        : Column(
                            children: [
                              const Text('Belum Dikerjakan',
                                  style: TextStyle(color: Colors.red)),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () => _startLatihan(),
                                  child: const Text('Mulai Mengerjakan')),
                            ],
                          )
                    : _isLoading
                        ? _circularProgressIndicator()
                        : Column(
                            children: [
                              const Text('Sudah Dikerjakan',
                                  style: TextStyle(color: Colors.green)),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () => _startLatihan(),
                                  child: const Text('Kerjakan Lagi')),
                            ],
                          ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              '${snapshot.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            );
          }
          return _circularProgressIndicator();
        },
      ),
    );
  }

  _startLatihan() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      List<Pertanyaan> pertanyaan =
          await PertanyaanServices.getPertanyaan(widget.latihan);
      if (pertanyaan.isEmpty) {
        myDialog(context: context, message: 'Pertanyaan Kosong!');
      } else {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/tampilLatihan',
            arguments:
                TampilLatihan(latihan: widget.latihan, pertanyaan: pertanyaan));
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        myDialog(context: context, message: e.toString());
      }
    }
  }
}

_circularProgressIndicator() {
  return const SizedBox(
    height: 50,
    width: 50,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
