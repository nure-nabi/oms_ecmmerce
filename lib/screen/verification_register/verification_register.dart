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

import '../../core/constant/colors_constant.dart';

class VerificationRegister extends StatefulWidget {
  const VerificationRegister({super.key});

  @override
  State<VerificationRegister> createState() => _VerificationRegisterState();
}

class _VerificationRegisterState extends State<VerificationRegister> {
  TextEditingController otpController = TextEditingController();
  String currentText = "";
  String completeText = "";
  String verificationEmail = "";

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
                SizedBox(height: 100,),
                Text("Please enter the 6-digit OTP code send to\n$verificationEmail via email",textAlign: TextAlign.center, style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.black)),
                BlocConsumer<VerificationBloc,VerificationState>(
                    builder: (BuildContext context, state){
                      if(state is VerificationInitialState){
                        return Column(
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
                            // Text("Resend the code",style: GoogleFonts.poppins(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w300,
                            //     color: Colors.black)),
                            // SizedBox(height: 20,),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if(completeText.length == 6){
                                    BlocProvider.of<VerificationBloc>(context).add(VerificationReqEvent(
                                        verificationReqModel: VerificationReqModel(verificationCode: completeText, email: "email0009@gmail.com")));
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
                        );
                      } else if(state is VerificationLoadingState){
                        return const Center(child: CircularProgressIndicator(),);
                      }else if(state is VerificationLoadedState){
                        return Center(child: Text(state.verificationResModel?.message??""),);
                      }else{
                        return Container();
                      }
                    },
                    listener: (BuildContext context,state){
                      if(state is VerificationLoadedState){
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
