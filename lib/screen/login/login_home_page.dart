import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/constant/asstes_list.dart';
import '../../core/constant/colors_constant.dart';
import '../../core/services/routeHelper/route_name.dart';



class LoginHomePage extends StatelessWidget {
  const LoginHomePage({super.key});


  Future<void> login() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the login process
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print('Error during Google login: $e');
      // Handle the error appropriately (show a message to user, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: gPrimaryColor.withOpacity(0.6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                child: Image.asset(
                  AssetsList.appIcon,
                  height: 150.0,
                ),
              ),
              SizedBox(height: 120,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: gPrimaryColor.withOpacity(0.3),width: 0.3)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Welcome dear user, do you want to',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gPrimaryColor.withOpacity(0.5)
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context,loginPath);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: gPrimaryColor, // Make button bg transparent
                            shadowColor: Colors.transparent, // Remove default shadow
                          ),
                          child:  Text(
                            'Login',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context,singupPath);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: gPrimaryColor, // Make button bg transparent
                            shadowColor: Colors.transparent, // Remove default shadow
                          ),
                          child:  Text(
                            'Sign Up/Register',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'or',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}