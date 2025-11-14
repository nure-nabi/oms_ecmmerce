


import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pointycastle/pointycastle.dart';

class PaymentFormPage extends StatefulWidget {
  @override
  State<PaymentFormPage> createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildHtmlForm());
  }

  // Future<void> generateToken() async {
  //   try {
  //     // Load PFX from assets
  //     final pfxData = await rootBundle.load('assets/images/CREDITOR.pfx');
  //     final pfxBytes = pfxData.buffer.asUint8List();
  //
  //     // Parse PFX
  //     final password = '123'; // your PFX password
  //     final p12 = Pkcs12Utils.getPrivateKeyFromPkcs12Bytes(pfxBytes, password);
  //     final privateKey = p12?.key as RSAPrivateKey;
  //
  //     // Example payload
  //     final payload = {
  //       'merchantID': '<merchant_id>',
  //       'transactionID': DateTime.now().millisecondsSinceEpoch.toString(),
  //       'amount': 1000
  //     };
  //     final message = utf8.encode(jsonEncode(payload)) as Uint8List;
  //
  //     // Sign with RSAPKCS1v15 and SHA-256
  //     final signer = Signer('SHA-256/RSA');
  //     signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));
  //     final sig = signer.generateSignature(message) as RSASignature;
  //
  //     final signatureBase64 = base64Encode(sig.bytes);
  //
  //     setState(() {
  //       token = signatureBase64;
  //     });
  //   } catch (e) {
  //     print('Error generating token: $e');
  //   }
  // }

  String _buildHtmlForm() {
    return '''
    <html>
    <body>
      <form action="https://uat.connectips.com/connectipswebgw/loginpage" method="post">
        <label for="MERCHANTID">MERCHANT ID</label>
        <input type="text" name="MERCHANTID" value="4064"/><br>

        <label for="APPID">APP ID</label>
        <input type="text" name="APPID" value="MER-4064-APP-1"/><br>

        <label for="APPNAME">APP NAME</label>
        <input type="text" name="APPNAME" value="Test Merchant Name"/><br>

        <label for="TXNID">TXN ID</label>
        <input type="text" name="TXNID" value="txn-123"/><br>

        <label for="TXNDATE">TXN DATE</label>
        <input type="text" name="TXNDATE" value="15-03-2022"/><br>

        <label for="TXNCRNCY">TXN CRNCY</label>
        <input type="text" name="TXNCRNCY" value="NPR"/><br>

        <label for="TXNAMT">TXN AMT</label>
        <input type="text" name="TXNAMT" value="500"/><br>

        <label for="REFERENCEID">REFERENCE ID</label>
        <input type="text" name="REFERENCEID" value="REF-001"/><br>

        <label for="REMARKS">REMARKS</label>
        <input type="text" name="REMARKS" value="RMKS-001"/><br>

        <label for="PARTICULARS">PARTICULARS</label>
        <input type="text" name="PARTICULARS" value="PART-001"/><br>

        <label for="TOKEN">TOKEN</label>
        <input type="text" name="TOKEN" value="fRLMniZSmpKs/FrO7w53NmlIiXKX1+AQdhJUgBO51S+Ho9ZzYOICghA5kW3hS/B1nf2EY5zziutxGejSBQ8NFgQo7MWYi/QPnSZ6jByI1gzRnx73/EUZmG9tRgRdDq2Zs99Y8m4by2uEQo0ZldbTHmO4kRuifUTSurFn+zdbprg="/><br>

        <input type="submit" value="Submit"/>
      </form>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ConnectIPS Payment')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
