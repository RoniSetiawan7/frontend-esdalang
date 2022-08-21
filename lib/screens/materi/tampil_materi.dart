import 'package:esdalang_app/models/materi.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TampilMateri extends StatefulWidget {
  final SubMateri subMateri;
  const TampilMateri({Key? key, required this.subMateri}) : super(key: key);

  @override
  State<TampilMateri> createState() => _TampilMateriState();
}

class _TampilMateriState extends State<TampilMateri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: widget.subMateri.nmMateri),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Bab ' + widget.subMateri.bab,
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
                child: TeXViewDocument(widget.subMateri.isiMateri),
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
