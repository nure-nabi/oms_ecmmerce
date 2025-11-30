import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/asstes_list.dart';
import 'package:oms_ecommerce/core/services/routeHelper/route_name.dart';
import 'package:oms_ecommerce/screen/forget_password/bloc/forget_password_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_bloc.dart';
import 'package:oms_ecommerce/screen/singup/block/register_event.dart';
import 'package:oms_ecommerce/screen/singup/block/register_state.dart';
import 'package:oms_ecommerce/screen/singup/model/register_model.dart';
import 'package:oms_ecommerce/screen/widget/gredient_container.dart';

import '../../../core/constant/colors_constant.dart';
import '../../service/sharepref/set_all_pref.dart';
import '../bloc/forget_password_bloc.dart';
import '../bloc/forget_password_state.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

//https://gargdental.omsok.com/api/v1/auth/forgot-password-code

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
       // backgroundColor: Colors.transparent,
        body: BlocConsumer<ForgetPasswordBloc,ForgetPasswordState>(
          builder: (BuildContext context, state) {
          if(state is ForgetPasswordInitialState){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 10),
                    Text(
                      'Forget password',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),

                    Form(
                      key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                            fillColor: Colors.white,
                            filled: true,

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email),
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
                            if (value != null && value.isNotEmpty) {
                              if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                            }else{
                              return 'Please enter a email';
                            }
                            return null; // Valid input
                          },

                        ),


                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              await SetAllPref.verificationEmail(value: emailController.text.trim());
                              if(_formKey.currentState!.validate() && emailController.text.isNotEmpty){
                                context.read<ForgetPasswordBloc>().add(ForgetPasswordReqEvent(
                                    email: emailController.text.trim()
                                ));

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
                            child: Text('Change password',
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),

                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'Already have an account',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Visibility(
                      visible: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.apple, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(state is ForgetPasswordLoadingState){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 10),
                    Text(
                      'Forget password',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),

                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Email',
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.email),
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
                                if (value != null && value.isNotEmpty) {
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                }
                                return null; // Valid input
                              },

                            ),


                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if(_formKey.currentState!.validate()){
                                    context.read<ForgetPasswordBloc>().add(ForgetPasswordReqEvent(
                                        email: emailController.text.trim()
                                    ));
                                    // await SetAllPref.verificationEmail(value: emailController.text.trim());
                                  }else{
                                    Fluttertoast.showToast(msg: "Email field required");
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
                                child: Text('Change password',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),

                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'Already have an account',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Visibility(
                      visible: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.apple, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else if(state is ForgetPasswordErrorState){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const SizedBox(height: 10),
                    Text(
                      'Forget password',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),

                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black38),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Email',
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(Icons.email),
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
                                if (value != null && value.isNotEmpty) {
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email';
                                  }
                                }
                                return null; // Valid input
                              },

                            ),


                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if(_formKey.currentState!.validate()){
                                    context.read<ForgetPasswordBloc>().add(ForgetPasswordReqEvent(
                                        email: emailController.text.trim()
                                    ));
                                    // await SetAllPref.verificationEmail(value: emailController.text.trim());
                                  }else{
                                    Fluttertoast.showToast(msg: "Email field required");
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
                                child: Text('Change password',
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )),

                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'Already have an account',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Visibility(
                      visible: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.facebook, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            icon: const Icon(Icons.apple, size: 30),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Container();
          }
        },
          listener: (BuildContext context, Object? state) {
            if(state is ForgetPasswordLoadedState){
              Navigator.pushNamed(context,
                  resetPasswordPage,
              );
            }
          },),
      ),
    );
  }
}
