import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FileViewerPage extends StatelessWidget {
    final String fileUrl;

  const FileViewerPage({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lihat File'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(Uri.parse(fileUrl).toString())),
      ),
    );
  }
}
