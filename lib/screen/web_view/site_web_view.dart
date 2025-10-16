import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SiteWebView extends StatelessWidget {
  const SiteWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("sd")
        // WebView(
        //   initialUrl: 'https://gargdental.vercel.app/',
        //   javascriptMode: JavascriptMode.unrestricted,
        //
        // ),
      ),
    );
  }
}
