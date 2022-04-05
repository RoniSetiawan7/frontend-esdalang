import 'package:esdalang_app/constant/url.dart';
import 'package:esdalang_app/models/kurikulum.dart';
import 'package:esdalang_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TampilKurikulum extends StatefulWidget {
  final Kurikulum kurikulum;
  const TampilKurikulum({Key? key, required this.kurikulum}) : super(key: key);

  @override
  State<TampilKurikulum> createState() => _TampilKurikulumState();
}

class _TampilKurikulumState extends State<TampilKurikulum> {
  InAppWebViewController? webView;
  String? url;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          context: context,
          title: widget.kurikulum.nmMateri,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () => webView?.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(
                      googleDocsUrl + baseUrl + widget.kurikulum.kurikulumPath),
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
                  url: Uri.parse(googleDocsUrl +
                      baseUrl +
                      widget.kurikulum.kurikulumPath)),
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
