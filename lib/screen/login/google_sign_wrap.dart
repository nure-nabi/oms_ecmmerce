// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:oms_ecommerce/screen/home_navbar/home_navbar.dart';
// import 'package:oms_ecommerce/screen/login/login_home_page.dart';
//
// class GoogleSignWrap extends StatefulWidget {
//   const GoogleSignWrap({super.key});
//
//   @override
//   State<GoogleSignWrap> createState() => _GoogleSignWrapState();
// }
//
// class _GoogleSignWrapState extends State<GoogleSignWrap> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//          if(snapshot.hasData){
//           return HomeNavbar();
//          }else{
//            return LoginHomePage();
//          }
//         },),
//     );
//   }
// }
