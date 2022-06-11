import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/pertanyaan.dart';
import 'package:esdalang_app/widgets/appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class TampilMateriLatihan extends StatefulWidget {
  final Pertanyaan pertanyaan;
  const TampilMateriLatihan({Key? key, required this.pertanyaan})
      : super(key: key);

  @override
  State<TampilMateriLatihan> createState() => _TampilMateriLatihanState();
}

class _TampilMateriLatihanState extends State<TampilMateriLatihan> {
  InAppWebViewController? _webViewController;
  String? url;
  double progress = 0;

  Future<void> _downloadFile() async {
    String url = baseUrl + widget.pertanyaan.materiPath;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak bisa membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: widget.pertanyaan.nmMateri +
              ' - Bab ' +
              widget.pertanyaan.bab.toString(),
          actions: [
            IconButton(
                onPressed: () => _downloadFile(),
                icon: const Icon(Icons.download)),
            IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  if (_webViewController != null) {
                    _webViewController?.reload();
                  }
                }),
          ]),
      body: Column(
        children: [
          Container(
              child: progress < 1
                  ? LinearProgressIndicator(value: progress)
                  : Container()),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(openDocumentUrl +
                      baseUrl +
                      widget.pertanyaan.materiPath)),
              onWebViewCreated: (controller) {
                _webViewController = controller;
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
