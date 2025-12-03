import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/services/routeHelper/route_name.dart';
import '../utils/custome_toast.dart';

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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            print("Page started loading: $url");

            if (url.contains("connectips/failure")) {
              CustomToast.showCustomRoast(context: context, message: "Transaction Failed",
                  icon: Bootstrap.check_circle,iconColor: Colors.red);
              Navigator.pushReplacementNamed(context, homeNavbar,
                  arguments: 3);
            } else if (url.contains("connectips/success")) {
              CustomToast.showCustomRoast(context: context!, message: "Transaction Successful",
                  icon: Bootstrap.check_circle,iconColor: Colors.green);
              Navigator.pushReplacementNamed(context, homeNavbar,
                  arguments: 3);
            }
          },
          onPageFinished: (url) {
            print("Page finished loading: $url");
          },
          onNavigationRequest: (request) {
            print("Navigation request: ${request.url}");
            return NavigationDecision.navigate;
          },
        ),
      );

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
      body: WebViewWidget(
          controller: controller
      ), // NEW widget in V4
    );
  }
}
