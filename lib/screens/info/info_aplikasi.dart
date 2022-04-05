import 'package:esdalang_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class InfoAplikasi extends StatelessWidget {
  const InfoAplikasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar(context: context, title: 'Tentang Aplikasi'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/merapi.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SizedBox(
                width: size.width,
                height: size.height * 0.25,
                child: Container(
                  alignment: const Alignment(0, 2.5),
                  child: CircleAvatar(
                    radius: 60,
                    child: CircleAvatar(
                      radius: 58,
                      child: Image.asset(
                        'assets/images/logo_smp.png',
                        width: size.width * 0.3,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 70, 16, 16),
              height: size.height * 0.5,
              width: size.width,
              child: Card(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Esdalang Mobile Learning App',
                      style: const TextStyle(fontWeight: FontWeight.w500)
                          .copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Esdalang Mobile Learning App merupakan aplikasi pembelajaran secara daring (Online Learning) yang \ndapat digunakan untuk menunjang kegiatan belajar mengajar di SMP Negeri 2 Kemalang selama \npandemi Covid-19.',
                      style: const TextStyle().copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Aplikasi ini dibuat menggunakan Framework Flutter, dengan Backend Laravel.',
                      style: const TextStyle().copyWith(height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
