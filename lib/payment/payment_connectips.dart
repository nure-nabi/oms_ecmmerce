import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConnectIPSWebView extends StatefulWidget {
  final String url;
  final Map<String, dynamic> payload;

  const ConnectIPSWebView({
    required this.url,
    required this.payload,
    super.key,
  });

  @override
  State<ConnectIPSWebView> createState() => _ConnectIPSWebViewState();
}

class _ConnectIPSWebViewState extends State<ConnectIPSWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    // Build the HTML form
    final formFields = widget.payload.entries
        .map((e) =>
    '<input type="hidden" name="${e.key}" value="${e.value}">')
        .join("");

    final htmlForm = """
      <html>
      <body onload="document.forms[0].submit()">
        <form method="POST" action="${widget.url}">
          $formFields
        </form>
      </body>
      </html>
    """;

    controller.loadHtmlString(htmlForm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ConnectIPS Payment")),
      body: WebViewWidget(controller: controller), // NEW widget in V4
    );
  }
}
