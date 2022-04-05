import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/screens/latihan/tampil_materi_latihan.dart';
import 'package:esdalang_app/screens/latihan/widgets/appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PembahasanLatihan extends StatelessWidget {
  final List<Pertanyaan> pertanyaan;
  final Map<int, dynamic> jawaban;

  const PembahasanLatihan(
      {Key? key, required this.pertanyaan, required this.jawaban})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: latihanAppBar(title: 'Pembahasan Latihan'),
      body: Container(
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
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: pertanyaan.length,
          itemBuilder: (context, index) {
            bool benar = pertanyaan[index].jawabanBenar == jawaban[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.all(8),
                child: ListBody(
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Html(data: pertanyaan[index].soal, style: {
                          'html': Style(
                              fontSize: const FontSize(16),
                              color: Colors.black),
                        })),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        '${jawaban[index]}',
                        style: TextStyle(
                          color: benar ? Colors.green : Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    benar
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Kunci Jawaban : ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      TextSpan(
                                        text: pertanyaan[index].jawabanBenar,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Pelajari kembali materi : ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: pertanyaan[index].nmMateri +
                                            ' Bab ' +
                                            pertanyaan[index].bab.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(
                                              context, '/tampilMateriLatihan',
                                              arguments: TampilMateriLatihan(
                                                pertanyaan: pertanyaan[index],
                                              )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
