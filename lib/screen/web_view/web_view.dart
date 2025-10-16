// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:oms_ecommerce/core/constant/colors_constant.dart';
// import 'package:path_provider/path_provider.dart';
//
// class WebViewPDF extends StatefulWidget {
//   final String? path;
//
//   WebViewPDF({Key? key, this.path}) : super(key: key);
//
//   _WebViewPDFState createState() => _WebViewPDFState();
// }
//
// class _WebViewPDFState extends State<WebViewPDF> with WidgetsBindingObserver {
//   final Completer<PDFViewController> _controller =
//   Completer<PDFViewController>();
//   int? pages = 0;
//   int? currentPage = 0;
//   bool isReady = false;
//   String errorMessage = '';
//   String googleDocsUrl = "https://gargdental.omsok.com/storage/app/public/backend/productcatalogue/P00013/201013_ora_aid_e_catalogue.pdf";
//
//   String? localPath;
//   bool isLoading = true;
//
//
//   @override
//   void initState() {
//     super.initState();
//     loadPdf();
//   }
//
//   Future<void> loadPdf() async {
//     try {
//       final file = await _downloadFile(googleDocsUrl);
//       Fluttertoast.showToast(msg: "downloaded");
//       setState(() {
//         localPath = file.path;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }
//
//   Future<File> _downloadFile(String url) async {
//     final filename = url.substring(url.lastIndexOf("/") + 1);
//     final request = await HttpClient().getUrl(Uri.parse(url));
//     final response = await request.close();
//     final bytes = await response.fold<BytesBuilder>(
//         BytesBuilder(), (builder, chunk) => builder..add(chunk));
//
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$filename');
//     await file.writeAsBytes(bytes.takeBytes());
//     return file;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Document"),
//         backgroundColor: gPrimaryColor,
//         leading: InkWell(
//           onTap: ()=>Navigator.pop(context),
//             child: Icon(Bootstrap.chevron_left)),
//         actions: <Widget>[
//
//         ],
//       ),
//       body: Stack(
//         children: <Widget>[
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : errorMessage.isNotEmpty
//               ? Center(child: Text(errorMessage))
//               : PDFView(
//              filePath: localPath,
//             enableSwipe: true,
//             swipeHorizontal: true,
//             autoSpacing: false,
//             pageFling: true,
//             pageSnap: true,
//             defaultPage: currentPage!,
//             fitPolicy: FitPolicy.BOTH,
//             preventLinkNavigation:
//             false, // if set to true the link is handled in flutter
//             backgroundColor: Color(0xFFFEF7FF),
//             onRender: (_pages) {
//               setState(() {
//                 pages = _pages;
//                 isReady = true;
//               });
//             },
//             onError: (error) {
//               setState(() {
//                 errorMessage = error.toString();
//               });
//               print(error.toString());
//             },
//             onPageError: (page, error) {
//               setState(() {
//                 errorMessage = '$page: ${error.toString()}';
//               });
//               print('$page: ${error.toString()}');
//             },
//             onViewCreated: (PDFViewController pdfViewController) {
//               _controller.complete(pdfViewController);
//             },
//             onLinkHandler: (String? uri) {
//               print('goto uri: $uri');
//             },
//             onPageChanged: (int? page, int? total) {
//               print('page change: ${page ?? 0 + 1}/$total');
//               setState(() {
//                 currentPage = page;
//               });
//             },
//           ),
//           errorMessage.isEmpty
//               ? !isReady
//               ? Center(
//             child: CircularProgressIndicator(),
//           )
//               : Container()
//               : Center(
//             child: Text(errorMessage),
//           )
//         ],
//       ),
//       floatingActionButton: FutureBuilder<PDFViewController>(
//         future: _controller.future,
//         builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
//           if (snapshot.hasData) {
//             return FloatingActionButton.extended(
//               label: Text("Go to ${pages! ~/ 2}"),
//               onPressed: () async {
//                 await snapshot.data!.setPage(pages! ~/ 2);
//               },
//             );
//           }
//
//           return Container();
//         },
//       ),
//     );
//   }
// }