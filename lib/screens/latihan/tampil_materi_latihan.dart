import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TampilMateriLatihan extends StatefulWidget {
  final Pertanyaan pertanyaan;
  const TampilMateriLatihan({Key? key, required this.pertanyaan})
      : super(key: key);

  @override
  State<TampilMateriLatihan> createState() => _TampilMateriLatihanState();
}

class _TampilMateriLatihanState extends State<TampilMateriLatihan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: widget.pertanyaan.nmMateri),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Bab ' + widget.pertanyaan.bab,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: TeXView(
                child: TeXViewDocument(widget.pertanyaan.isiMateri),
                style: const TeXViewStyle(margin: TeXViewMargin.all(10)),
                renderingEngine: const TeXViewRenderingEngine.katex(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
