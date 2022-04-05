import 'dart:convert';

import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/latihan.dart';
import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/screens/latihan/hasil_latihan.dart';
import 'package:esdalang_app/services/http_services.dart';
import 'package:esdalang_app/widgets/dialog.dart';
import 'package:esdalang_app/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/appbar.dart';

class TampilLatihan extends StatefulWidget {
  final Latihan latihan;
  final List<Pertanyaan> pertanyaan;

  const TampilLatihan(
      {Key? key, required this.latihan, required this.pertanyaan})
      : super(key: key);

  @override
  _TampilLatihanState createState() => _TampilLatihanState();
}

class _TampilLatihanState extends State<TampilLatihan> {
  int _indexSekarang = 0;
  final Map<int, dynamic> _jawaban = {};
  bool _isLoading = false;
  int? nis;

  @override
  void initState() {
    super.initState();
    _loadNIS();
  }

  _loadNIS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var nisSiswa = jsonDecode(prefs.getString('nis')!);

    setState(() {
      nis = nisSiswa;
    });
  }

  _showSuccessMsg(msg) {
    mySnackBar(
        context: context, message: '✔   ' + msg, color: Colors.green.shade400);
  }

  @override
  Widget build(BuildContext context) {
    Pertanyaan pertanyaan = widget.pertanyaan[_indexSekarang];
    final List<dynamic> options = pertanyaan.jawabanSalah;

    if (!options.contains(pertanyaan.jawabanBenar)) {
      options.add(pertanyaan.jawabanBenar);
      options.shuffle();
    }

    final keteranganGambar = widget.pertanyaan[_indexSekarang].ketGambar;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: latihanAppBar(title: widget.latihan.nmLatihan),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Text(
                        'Soal '
                        '${_indexSekarang + 1}'
                        ' / '
                        '${widget.pertanyaan.length}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      alignment: Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  keteranganGambar == null
                      ? Container()
                      : SizedBox(
                          height: 150,
                          child: Image.network(
                            baseUrl +
                                widget.pertanyaan[_indexSekarang].imagePath!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                  Html(
                    data: widget.pertanyaan[_indexSekarang].soal,
                    style: {
                      'html': Style(
                          fontSize: const FontSize(16), color: Colors.white),
                    },
                  ),
                  const SizedBox(height: 25),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...options.map(
                          (e) => RadioListTile(
                            activeColor: Colors.black54,
                            title: Text(
                              e,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                            groupValue: _jawaban[_indexSekarang],
                            value: e.toString(),
                            onChanged: (value) {
                              setState(() {
                                _jawaban[_indexSekarang] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black54,
                          ),
                          onPressed: () async => _previous(),
                          child: const Text(
                            'Prev',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        width: 150,
                        height: 50,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black54,
                          ),
                          onPressed: () async => _submit(),
                          child: Text(
                            _isLoading
                                ? 'Loading...'
                                : _indexSekarang ==
                                        (widget.pertanyaan.length - 1)
                                    ? 'Submit'
                                    : 'Next',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        width: 150,
                        height: 50,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _previous() {
    if (_indexSekarang > 0) {
      setState(() {
        _indexSekarang--;
      });
    }
  }

  void _submit() async {
    if (_jawaban[_indexSekarang] == null) {
      myDialog(context: context, message: 'Pilih salah satu jawaban');
    } else if (_indexSekarang < (widget.pertanyaan.length - 1)) {
      setState(() {
        _indexSekarang++;
      });
    } else {
      setState(() {
        _isLoading = true;
      });

      int benar = 0;
      _jawaban.forEach((index, value) {
        if (widget.pertanyaan[index].jawabanBenar == value) {
          benar++;
        }
      });
      double nilai = benar / widget.pertanyaan.length * 100;

      var data = {
        'id_siswa': nis,
        'id_latihan': widget.latihan.kodeLatihan,
        'jawaban': _jawaban.toString(),
        'nilai': nilai,
      };

      var res = await HttpServices.postData(data, '/hasil-latihan');
      var body = json.decode(res.body);
      print(body);

      if (body['success']) {
        _showSuccessMsg(body['message']);
        Navigator.pushReplacementNamed(context, '/hasilLatihan',
            arguments:
                HasilLatihan(pertanyaan: widget.pertanyaan, jawaban: _jawaban));
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Keluar'),
          content: const Text(
            'Semua progress anda akan hilang!',
          ),
          actions: [
            TextButton(
              child: const Text('Ya'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
            TextButton(
              child: const Text('Tidak'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
