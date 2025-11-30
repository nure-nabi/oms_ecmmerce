import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oms_ecommerce/component/loading_overlay.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_bloc.dart';
import 'package:oms_ecommerce/screen/address/bloc/address_event.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_bloc.dart';
import 'package:oms_ecommerce/screen/cart/bloc/cart_event.dart';
import 'package:oms_ecommerce/screen/login/api/login_repo.dart';
import 'package:oms_ecommerce/screen/login/model/login_req_model.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_event.dart';
import 'package:oms_ecommerce/screen/profile/block/profile_bloc/profile_state.dart';

import '../../../core/services/routeHelper/route_name.dart';
import '../../home_navbar/home_navbar.dart';
import '../../profile/block/profile_bloc/profile_bloc.dart';
import '../../service/sharepref/pref_text.dart';
import '../../service/sharepref/set_all_pref.dart';
import '../../service/sharepref/share_preference.dart';
import '../login_page.dart';

class AuthService {

  static Future<void> loginWithGoogle(BuildContext context) async {

    String webClientId = "487714998715-2f5e1fbrlkngea825u0eej84veth63po.apps.googleusercontent.com";

    try {
      await FirebaseAuth.instance.setLanguageCode("en");
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.initialize(serverClientId: webClientId);
      GoogleSignInAccount accountDetails = await signIn.authenticate();
     // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (accountDetails == null) {
        // User canceled the login process
        return;
      }
      final GoogleSignInAuthentication googleAuth = await accountDetails.authentication;
      final credential = await GoogleAuthProvider.credential(
      //  accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      LoadingOverlay.show(context);


      final currentUser = await FirebaseAuth.instance.currentUser;
      LoginRespModel reqModel =await LoginAPI.loginGoogleRegister(
          token: credential.idToken.toString(),
          unique_id: currentUser!.uid,
          access_token: "0");

      if(reqModel.success == true){
       LoadingOverlay.hide();
        await SetAllPref.loginSuccess(value: true);
        await SetAllPref.userId(value: reqModel.user!.id.toString());
        await SetAllPref.token(value: reqModel.token!.toString());
       context.read<ProfileBloc>().add(ProfileClearDataEvent());
       context.read<CartBloc>().add(CartClearEvent());
       context.read<AddressBloc>().add(AddressClearEvent());
        navigateHomePage(context);
      }else{
        Fluttertoast.showToast(msg: "No login!");
      }


    } catch (e) {
      print('Error during Google login: $e');
      // Handle the error appropriately (show a message to user, etc.)
    }
  }

  static logout(BuildContext context) async {
    await logOut(context);
    await logoutGmail();
  //  await FirebaseAuth.instance.signOut();
  }

  static navigateHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeNavbar, arguments: 0);
    Fluttertoast.showToast(msg: "Login successfully");
  }

static  logOut(context) async {
    await SharedPref.removeData(key: PrefText.loginSuccess, type: "bool");
    await SharedPref.removeData(key: PrefText.token, type: "String");
    await SharedPref.removeData(key: PrefText.userName, type: "String");

  // Dispatch logout to all BLoCs
   // context.read<ProfileBloc>().add(ProfileErrorState());
   //  context.read<CartBloc>().add(CartReset());
   // LoadingOverlay.hide();
    await refreshPageToLogIn(context);
  }

 static refreshPageToLogIn(context) async {
    Navigator.pushAndRemoveUntil(
      context,
     // MaterialPageRoute(builder: (context) =>  LoginPage()), (route) => false,  // This condition removes all previous routes
      MaterialPageRoute(builder: (context) =>  HomeNavbar(index: 0,)), (route) => false,  // This condition removes all previous routes
    );
    Fluttertoast.showToast(msg: "Logout successfully");
  }

 static Future<void> logoutGmail() async {
    try {
      GoogleSignIn signIn = GoogleSignIn.instance;
      await signIn.signOut();
     // await FirebaseAuth.instance.signOut();
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Logout failed: $e")),
      // );
    }
  }



}