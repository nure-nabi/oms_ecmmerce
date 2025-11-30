import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/service/sharepref/get_all_pref.dart';
import 'package:oms_ecommerce/screen/verification_register/model/verification_model.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_bloc/verification_bloc.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_bloc/verification_event.dart';
import 'package:oms_ecommerce/screen/verification_register/verification_bloc/verification_state.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constant/colors_constant.dart';
import '../bloc/reset_password_bloc.dart';
import '../bloc/reset_password_event.dart';
import '../bloc/reset_password_state.dart';


class ResetPasswordPage extends StatefulWidget {

  ResetPasswordPage({super.key,});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newConfirmationPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  String completeText = "";
  String verificationEmail = "";
  bool isNewPasswordObscured = false;

  @override
  void initState() {
    verificationEmailShow();
    super.initState();
  }

  verificationEmailShow() async{
    verificationEmail = await GetAllPref.verificationEmail();
    //  Fluttertoast.showToast(msg: 'eMAIL   ${verificationEmail}');
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: const Icon(Bootstrap.chevron_left)),

                      ],
                    ),
                  ),
                  Image.asset("assets/icons/authicon.png",height: 177,width: 177,),
                  SizedBox(height: 40,),
                  Text("Please enter the 6-digit OTP code send to\n$verificationEmail via email",textAlign: TextAlign.center, style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black)),
                  BlocConsumer<ResetPasswordBloc,ResetPasswordState>(
                      builder: (BuildContext context, state){
                        if(state is ResetPasswordInitialState){
                          return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                PinCodeTextField(
                                  appContext: context,
                                  length: 6,
                                  controller: otpController,
                                  onChanged: (value) {
                                    setState(() {
                                      currentText = value;

                                    });
                                  },
                                  onCompleted: (value) {
                                    // Handle OTP verification here
                                    debugPrint("Completed OTP: $value");
                                    completeText = value;

                                  },
                                  // Styling options:
                                  backgroundColor: Colors.transparent,
                                  enableActiveFill: true,
                                  keyboardType: TextInputType.number,
                                  textStyle: const TextStyle(fontSize: 20),
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(8),
                                    fieldHeight: 45,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.white,
                                    activeColor: Colors.green,
                                    inactiveFillColor: Colors.grey[200],
                                    inactiveColor: Colors.grey[400],
                                    selectedFillColor: Colors.blue[100],
                                    selectedColor: Colors.blue,
                                  ),
                                  cursorColor: Colors.blue,
                                  animationDuration: const Duration(milliseconds: 300),
                                  enablePinAutofill: true,
                                  autoFocus: true,
                                ),
                                SizedBox(height: 20,),
                                Text(
                                  'New Password *',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                ),
                                 SizedBox(height: 10,),
                                TextFormField(
                                  controller: newPasswordController,
                                  obscureText: isNewPasswordObscured,
                                  decoration: InputDecoration(
                                    hintText: "New Password",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38),
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        isNewPasswordObscured ? Icons.visibility_off : Icons.visibility,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isNewPasswordObscured = !isNewPasswordObscured;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.password),
                                    // For a more complete styling, you might also want to add:
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey), // Optional: customize border color
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue), // Optional: focus color
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter old password';
                                    }
                                    return null; // Valid input
                                  },
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Confirm Password *',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black38),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: newConfirmationPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password ",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.password),
                                    // For a more complete styling, you might also want to add:
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color:
                                          Colors.grey), // Optional: customize border color
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue), // Optional: focus color
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    } else if (value != newPasswordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      Fluttertoast.showToast(msg: await  GetAllPref.verificationEmail());
                                      if(_formKey.currentState!.validate() &&completeText.length == 6){
                                        BlocProvider.of<ResetPasswordBloc>(context).add(ResetPasswordReqEvent(
                                            email:await  GetAllPref.verificationEmail(),
                                            reset_code: completeText,
                                            new_password: newPasswordController.text.trim(),
                                            confirm_new_password: newConfirmationPasswordController.text.trim()));
                                      }else{
                                        Fluttertoast.showToast(msg: "Please enter 6-digit code");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: gPrimaryColor, // Make button bg transparent
                                      shadowColor: Colors.transparent, // Remove default shadow
                                    ),
                                    child: Text('Verify OTP',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                  ),
                                ),


                              ],
                            ),
                          );
                        } else if(state is VerificationLoadedState){
                          return Center(child: Text("yu"),);
                        }else{
                          return Container();
                        }
                      },
                      listener: (BuildContext context,state){
                        if(state is ResetPasswordLoadedState){
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              loginPath,
                                  (Route<dynamic> route) => false, // This removes all routes
                            );


                          //  Navigator.pushNamed(context,loginPath);
                        }
                      })
                ],
              ),
            ),
          )
      ),
    );
  }
}
