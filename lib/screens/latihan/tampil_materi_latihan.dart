import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TampilMateriLatihan extends StatefulWidget {
  final Pertanyaan pertanyaan;
  const TampilMateriLatihan({Key? key, required this.pertanyaan})
      : super(key: key);

  @override
  State<TampilMateriLatihan> createState() => _TampilMateriLatihanState();
}

class _TampilMateriLatihanState extends State<TampilMateriLatihan> {
  InAppWebViewController? webView;
  String? url;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: widget.pertanyaan.nmMateri +
              ' Bab ' +
              widget.pertanyaan.bab.toString(),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () => webView?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(
                      googleDocsUrl + baseUrl + widget.pertanyaan.materiPath),
                ),
              ),
            )
          ]),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              child: progress < 1
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      googleDocsUrl + baseUrl + widget.pertanyaan.materiPath)),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url?.toString() ?? '';
                });
              },
              onLoadStop: (controller, url) async {
                setState(() {
                  this.url = url?.toString() ?? '';
                });
              },
              onProgressChanged: (controller, progress) {
                setState(
                  () {
                    this.progress = progress / 100;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
