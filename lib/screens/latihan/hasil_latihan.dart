import 'package:esdalang_app/functions/emoji.dart';
import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/screens/latihan/pembahasan_latihan.dart';
import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import 'widgets/list_tile.dart';

class HasilLatihan extends StatelessWidget {
  final List<Pertanyaan> pertanyaan;
  final Map<int, dynamic> jawaban;
  const HasilLatihan(
      {Key? key, required this.pertanyaan, required this.jawaban})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int benar = 0;

    jawaban.forEach((index, value) {
      if (pertanyaan[index].jawabanBenar == value) {
        benar++;
      }
    });

    return Scaffold(
      appBar: latihanAppBar(title: 'Hasil Latihan'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.blueAccent,
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(
                      getEmoji(
                        (benar / pertanyaan.length * 100).toInt(),
                      ),
                      alignment: Alignment.center,
                      height: 130,
                    ),
                    const SizedBox(height: 10),
                    LatihanListTile(
                      leading: 'Skor',
                      trailing:
                          '${(benar / pertanyaan.length * 100).toStringAsFixed(2)} / 100',
                    ),
                    LatihanListTile(
                      leading: 'Jawaban Benar',
                      trailing: '$benar / ${pertanyaan.length}',
                    ),
                    LatihanListTile(
                      leading: 'Jawaban Salah',
                      trailing:
                          '${pertanyaan.length - benar} / ${pertanyaan.length}',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Kembali Ke List Latihan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                width: double.infinity,
                height: 50,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/pembahasanLatihan',
                        arguments: PembahasanLatihan(
                            pertanyaan: pertanyaan, jawaban: jawaban));
                  },
                  child: const Text(
                    'Pembahasan Latihan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                width: double.infinity,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
