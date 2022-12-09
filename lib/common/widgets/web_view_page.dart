import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String initialUrl;

  const WebViewPage({Key? key, required this.initialUrl}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.initialUrl,
      userAgent: "Android Duuchin",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController controller) {
        _webViewController = controller;
      },
      onProgress: (int progress) {
        print('=====onProgress=====>$progress');
      },
      onPageStarted: (String url) {
        print('=====onPageStarted=====>$url');
      },
      onPageFinished: (String url) {
        print('=====onPageFinished=====>$url');
      },
      onWebResourceError: (WebResourceError error) {
        print('=====error=====>$error');
      },
    );
  }
}
